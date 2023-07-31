import 'dart:async';
import 'dart:convert';

import 'package:ilp_file_codec/ilp_codec.dart';
import 'package:ilp_file_codec/src/utils.dart';
import 'package:path/path.dart' as path;
import 'package:universal_io/io.dart';

class ILPInfoConfig {
  String name, cover;
  String? filePath;
  int width, height;
  ILPLayerConfig layer;
  String? _id;

  ILPInfoConfig({
    this.filePath,
    required this.name,
    required this.width,
    required this.height,
    required this.cover,
    required this.layer,
  });

  factory ILPInfoConfig.fromFileSync(String file) {
    return ILPInfoConfig.fromJson(
      _readFileSync(File(file)),
      filePath: file,
      name: path.basenameWithoutExtension(file),
    );
  }

  static Future<ILPInfoConfig> fromFile(String file) async {
    return ILPInfoConfig.fromJson(
      await _readFile(File(file)),
      filePath: file,
      name: path.basenameWithoutExtension(file),
    );
  }

  factory ILPInfoConfig.fromJson(Map map, {String? filePath, String? name}) {
    if (!map.containsKey('width')) {
      throw ILPConfigException(message: 'info_missing_width', file: filePath);
    }
    if (!map.containsKey('height')) {
      throw ILPConfigException(message: 'info_missing_height', file: filePath);
    }
    if (!map.containsKey('cover')) {
      throw ILPConfigException(message: 'info_missing_cover', file: filePath);
    }
    if (!File(map['cover']).existsSync()) {
      throw ILPConfigException(
        message: 'info_cover_not_exists',
        file: filePath,
      );
    }
    if (!map.containsKey('layers')) {
      throw ILPConfigException(message: 'info_missing_layers', file: filePath);
    }

    try {
      return ILPInfoConfig(
        filePath: filePath,
        name: name ?? map['name'],
        width: map['width'],
        height: map['height'],
        cover: map['cover'],
        layer: ILPLayerConfig(
          name: 'background',
          x: 0,
          y: 0,
          width: map['width'],
          height: map['height'],
          file: map['background'],
          layers: List.from(map['layers'].map((m) => ILPLayerConfig.create(m))),
        ),
      );
    } on ILPConfigException catch (e) {
      e.file = filePath;
      rethrow;
    }
  }

  Future<String> get id async => _id ??= await layer.id;

  Future<ILPInfo> toILPInfo() async {
    final futures = <Future<String>>[
      layer.id,
      ...layer.contentLayers.map((layer) => layer.id)
    ];

    final ilp = ILPInfo()
      ..name = name
      ..width = width
      ..height = height
      ..cover = await File(cover).readAsBytes();
    ilp.contentLayerIdList
      ..clear()
      ..addAll(await Future.wait(futures));
    return ilp;
  }

  /// validate all files exists
  /// true validate success
  /// false validate fail
  Future<bool> validate() async {
    final res = await Future.wait([
      File(cover).exists(),
      if (filePath != null) File(filePath!).exists(),
      layer.validate(),
    ]);
    return !res.contains(false);
  }
}

class ILPLayerConfig {
  final int? width, height, x, y;
  String? name, file;
  final List<ILPLayerConfig>? layers;

  ILPLayerConfig({
    this.name,
    this.width,
    this.height,
    this.x,
    this.y,
    this.file,
    this.layers,
  });

  bool get hasLayers => layers?.isNotEmpty == true;

  bool get hasFile => file != null;

  factory ILPLayerConfig.create(dynamic data) {
    if (data is List) {
      return ILPLayerConfig(
        layers: List.from(data.map((e) => ILPLayerConfig.create(e))),
      );
    } else if (data is Map) {
      if (data.containsKey('layers')) {
        return ILPLayerConfig(
          name: data['name'],
          layers: List.from(
            data['layers'].map((e) => ILPLayerConfig.create(e)),
          ),
        );
      } else {
        if (!data.containsKey('width')) {
          throw ILPConfigException(message: 'layer_missing_width');
        }
        if (!data.containsKey('height')) {
          throw ILPConfigException(message: 'layer_missing_height');
        }
        if (!data.containsKey('x')) {
          throw ILPConfigException(message: 'layer_missing_x');
        }
        if (!data.containsKey('y')) {
          throw ILPConfigException(message: 'layer_missing_y');
        }
        if (!data.containsKey('file')) {
          throw ILPConfigException(message: 'layer_missing_file');
        }
        if (!File(data['file']).existsSync()) {
          throw ILPConfigException(message: 'layer_file_not_exists');
        }
        return ILPLayerConfig(
          name: data['name'],
          width: data['width'],
          height: data['height'],
          x: data['x'],
          y: data['y'],
          file: data['file'],
        );
      }
    } else {
      throw ILPConfigException(message: 'layer_data_error');
    }
  }

  List<ILPLayerConfig> search(String name) {
    final data = <ILPLayerConfig>[];
    if (hasLayers) _where(data, layers!, name);
    return data;
  }

  static _where(
      List<ILPLayerConfig> store, List<ILPLayerConfig> layers, String name) {
    for (final layer in layers) {
      if (layer.name?.contains(name) == true) store.add(layer);
      if (layer.hasLayers) {
        _where(store, layer.layers!, name);
      }
    }
  }

  /// Only count content layers
  int count() {
    var count = 0;
    innerCount(ILPLayerConfig layer) {
      if (layer.hasFile) {
        count++;
      }
      if (layer.hasLayers) {
        layer.layers!.forEach(innerCount);
      }
    }

    innerCount(this);
    return count;
  }

  /// Convert to ILPLayer
  Future<ILPLayer> toLayer(bool isBackGroundLayer) async {
    final layer = ILPLayer();
    if (name != null) layer.name = name!;
    if (hasFile) {
      final bytes = await File(file!).readAsBytes();
      layer.content = bytes;
      layer.id = bytesSha1(bytes);
    }
    if (isBackGroundLayer) {
      layer.width = width!;
      layer.height = height!;
      layer.x = x!;
      layer.y = y!;
      layer.content = await File(file!).readAsBytes();
      for (final l in layers!) {
        layer.layers.add(await l.toLayer(false));
      }
    } else {
      if (layers == null) {
        layer.width = width!;
        layer.height = height!;
        layer.x = x!;
        layer.y = y!;
        layer.content = await File(file!).readAsBytes();
      } else {
        for (final l in layers!) {
          layer.layers.add(await l.toLayer(false));
        }
      }
    }
    return layer;
  }

  Future<String> get id async {
    if (!hasFile) {
      throw ILPConfigException(message: 'layer_no_file');
    }
    if (!(await File(file!).exists())) {
      throw ILPConfigException(message: 'layer_file_not_exists');
    }
    return fileSha1(File(file!));
  }

  /// return children content layers
  List<ILPLayerConfig> get contentLayers {
    final list = <ILPLayerConfig>[];
    loop(List<ILPLayerConfig> layers) {
      for (var layer in layers) {
        if (layer.hasFile) list.add(layer);
        if (layer.hasLayers) loop(layer.layers!);
      }
    }

    if (layers != null) loop(layers!);
    return list;
  }

  /// validate layers file exists
  /// true validate success
  /// false validate fail
  Future<bool> validate() async {
    final res = await Future.wait([
      File(file!).exists(),
      ...contentLayers.map((e) => File(e.file!).exists()),
    ]);
    return !res.contains(false);
  }
}

Map _readFileSync(File file) {
  if (!file.existsSync()) {
    throw ILPConfigException(message: 'info_file_not_exists', file: file.path);
  }
  late String data;
  try {
    data = file.readAsStringSync();
  } catch (e) {
    throw ILPConfigException(
        message: 'info_file_not_string_file', file: file.path);
  }
  Map map;
  try {
    map = jsonDecode(data);
  } catch (e) {
    throw ILPConfigException(message: 'info_file_parse_error', file: file.path);
  }
  return map;
}

Future<Map> _readFile(File file) async {
  if (!file.existsSync()) {
    throw ILPConfigException(message: 'info_file_not_exists', file: file.path);
  }
  late String data;
  try {
    data = await file.readAsString();
  } catch (e) {
    throw ILPConfigException(
        message: 'info_file_not_string_file', file: file.path);
  }
  Map map;
  try {
    map = jsonDecode(data);
  } catch (e) {
    throw ILPConfigException(message: 'info_file_parse_error', file: file.path);
  }
  return map;
}
