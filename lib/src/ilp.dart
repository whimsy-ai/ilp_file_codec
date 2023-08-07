import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:ilp_file_codec/ilp_codec.dart';
import 'package:universal_io/io.dart';

import 'utils.dart';

enum ILPType {
  file,
  configFiles,
  bytes,
}

final _gzipEncoder = GZipEncoder();
final _gzipDecoder = GZipDecoder();

abstract class _ILPDataSource {
  ILPType get type;

  Future<bool> get isList;

  Future<bool> get isILP;

  Future<ILPHeader> get header;

  Future<ILPInfo> info(int index);

  Future<List<ILPInfo>> get infos;

  Future<ILPLayer> layer(int index);

  Future<String> get md5 async {
    final ilpHeader = await header;
    return crypto.md5
        .convert([...ilpHeader.infoList, ...ilpHeader.layerList]).toString();
  }

  Future<String> get sha1 async {
    final ilpHeader = await header;
    return crypto.sha1
        .convert([...ilpHeader.infoList, ...ilpHeader.layerList]).toString();
  }

  Future<int> get _headerLength;

  Future<int> get length async {
    final ilpHeader = await header;
    return ilpFileHeaderStart +
        await _headerLength +
        ilpHeader.infoList.sum +
        ilpHeader.layerList.sum;
  }
}

class _ILPBytes extends _ILPDataSource {
  @override
  final type = ILPType.bytes;
  final Uint8List bytes;
  ILPHeader? _header;
  late int _infoStart, _infoTotalLength;

  _ILPBytes(this.bytes);

  @override
  Future<ILPHeader> get header {
    if (_header == null) {
      final headerLength = bytes
          .sublist(ilpFileFixedStringsLength, ilpFileHeaderStart)
          .buffer
          .asByteData()
          .getInt32(0);
      final headerBytes =
          bytes.sublist(ilpFileHeaderStart, ilpFileHeaderStart + headerLength);
      _header = ILPHeader.fromBuffer(_gzipDecoder.decodeBytes(headerBytes));
      _infoStart = ilpFileHeaderStart + headerLength;
      _infoTotalLength = _header!.infoList.sum;
    }
    return Future.value(_header);
  }

  @override
  Future<ILPInfo> info(int index) async {
    await header;
    assert(index < _header!.infoList.length);
    final infoLength = _header!.infoList[index];
    final skip = _infoStart + _header!.infoList.take(index).sum;
    return ILPInfo.fromBuffer(
      _gzipDecoder.decodeBytes(bytes.sublist(skip, skip + infoLength)),
    );
  }

  @override
  Future<List<ILPInfo>> get infos async {
    await header;
    final list = <ILPInfo>[];
    for (var index = 0; index < _header!.infoList.length; index++) {
      final infoLength = _header!.infoList[index];
      final skip = _infoStart + _header!.infoList.take(index).sum;
      final infoBytes = bytes.sublist(skip, skip + infoLength);
      list.add(ILPInfo.fromBuffer(_gzipDecoder.decodeBytes(infoBytes)));
    }
    return list;
  }

  @override
  Future<bool> get isILP => Future.value(isILPFile(bytes));

  @override
  Future<bool> get isList async {
    await header;
    return _header!.infoList.length > 1;
  }

  @override
  Future<ILPLayer> layer(int index) async {
    await header;
    assert(index < _header!.infoList.length);
    final length = _header!.layerList[index];
    var position =
        _infoStart + _infoTotalLength + _header!.layerList.take(index).sum;
    return ILPLayer.fromBuffer(
      _gzipDecoder.decodeBytes(bytes.sublist(position, position + length)),
    );
  }

  @override
  Future<int> get length => Future.value(bytes.length);

  @override
  Future<int> get _headerLength => Future.value(bytes
      .sublist(ilpFileFixedStringsLength, ilpFileHeaderStart)
      .buffer
      .asByteData()
      .getInt32(0));
}

class _ILPFile extends _ILPDataSource {
  @override
  final type = ILPType.file;
  final File file;
  late int _infoStart, _infoTotalLength;
  ILPHeader? _header;

  _ILPFile(this.file);

  @override
  Future<bool> get isILP async {
    final raf = await file.open();
    final is_ = isILPFile(await raf.read(ilpFileFixedStringsLength));
    await raf.close();
    return is_;
  }

  @override
  Future<bool> get isList async {
    final raf = await _getHeader();
    final isList = _header!.infoList.length > 1;
    await raf.close();
    return isList;
  }

  @override
  Future<ILPHeader> get header async {
    if (_header == null) {
      final raf = await _getHeader();
      await raf.close();
    }
    return _header!;
  }

  @override
  Future<ILPInfo> info(int index) async {
    final raf = await _getHeader();
    assert(index < _header!.infoList.length);
    final infoLength = _header!.infoList[index];
    final skip = _infoStart + _header!.infoList.take(index).sum;
    // print('header ${_header!.writeToJson()}'
    //     ' skip:$skip'
    //     ' infoLength:$infoLength');
    await raf.setPosition(skip);
    final infoBytes = await raf.read(infoLength);

    final ilp = ILPInfo.fromBuffer(_gzipDecoder.decodeBytes(infoBytes));
    await raf.close();
    return ilp;
  }

  @override
  Future<List<ILPInfo>> get infos async {
    final raf = await _getHeader();
    final list = <ILPInfo>[];
    for (var index = 0; index < _header!.infoList.length; index++) {
      final infoLength = _header!.infoList[index];
      final skip = _infoStart + _header!.infoList.take(index).sum;
      await raf.setPosition(skip);
      final infoBytes = await raf.read(infoLength);
      list.add(ILPInfo.fromBuffer(_gzipDecoder.decodeBytes(infoBytes)));
    }

    await raf.close();
    return list;
  }

  @override
  Future<ILPLayer> layer(int index) async {
    final raf = await _getHeader();
    assert(index < _header!.layerList.length);
    final length = _header!.layerList[index];
    var position =
        _infoStart + _infoTotalLength + _header!.layerList.take(index).sum;
    await raf.setPosition(position);
    final layer =
        ILPLayer.fromBuffer(_gzipDecoder.decodeBytes(await raf.read(length)));
    await raf.close();
    return layer;
  }

  Future<RandomAccessFile> _getHeader() async {
    final raf = await file.open();
    try {
      if (_header == null) {
        await raf.setPosition(ilpFileFixedStringsLength);
        final headerLength =
            (await raf.read(4)).buffer.asByteData().getInt32(0);
        _header = ILPHeader.fromBuffer(
            _gzipDecoder.decodeBytes(await raf.read(headerLength)));
        _infoStart = ilpFileHeaderStart + headerLength;
        _infoTotalLength = _header!.infoList.sum;

        /// here don't close the raf
        ///await raf.close();
      }
      return raf;
    } catch (e) {
      await raf.close();
      throw ILPConfigException(
        message: 'ilp_file_parse_error',
        file: file.path,
      );
    }
  }

  @override
  Future<int> get _headerLength async {
    final raf = await file.open();
    await raf.setPosition(ilpFileFixedStringsLength);
    final headerLength = (await raf.read(4)).buffer.asByteData().getInt32(0);
    await raf.close();
    return headerLength;
  }
}

class _ILPConfig extends _ILPDataSource {
  @override
  final type = ILPType.configFiles;
  final List<ILPInfoConfig> _configs = [];

  _ILPConfig(List<File> files) {
    _load(files);
  }

  _load(List<File> files) {
    _configs.addAll(files.map((file) => ILPInfoConfig.fromFileSync(file.path)));
  }

  @override
  Future<bool> get isILP {
    return Future.value(true);
  }

  @override
  Future<bool> get isList => Future.value(_configs.length > 1);

  @override
  Future<ILPHeader> get header async {
    final header = ILPHeader();
    final infos = await this.infos;
    for (var i = 0; i < infos.length; i++) {
      final info = infos[i];
      final layer = await this.layer(i);
      header.infoList.add(_gzipEncoder.encode(info.writeToBuffer())!.length);
      header.layerList.add(_gzipEncoder.encode(layer.writeToBuffer())!.length);
    }
    return header;
  }

  @override
  Future<int> get _headerLength async {
    final h = await header;
    return _gzipEncoder.encode(h.writeToBuffer())!.length;
  }

  @override
  Future<ILPInfo> info([int index = 0]) {
    return _configs[index].toILPInfo();
  }

  @override
  Future<List<ILPInfo>> get infos async {
    final list = <ILPInfo>[];
    for (var info in _configs) {
      list.add(await info.toILPInfo());
    }
    return list;
  }

  @override
  Future<ILPLayer> layer([int index = 0]) async {
    return _configs[index].layer.toLayer(true);
  }

  Future<Uint8List> toBytes({
    required String author,
    required String name,
    required int version,
    String? description,
    List<String>? links,
    String? coverFilePath,
    List<ILPInfo>? infos,
    List<ILPLayer>? layers,
  }) async {
    assert(_configs.isNotEmpty);
    assert(version > 0);
    final header = ILPHeader();
    header.id = await _configs.first.id;
    header.author = author;
    header.name = name;
    header.version = version;
    if (description != null) header.description = description;
    if (links != null) header.links.addAll(links);
    if (coverFilePath != null) {
      header.cover =
          _gzipEncoder.encode(await File(coverFilePath).readAsBytes())!;
    }
    final List<int> infoList = [], layerList = [];
    if (infos == null) {
      infos = [];
      for (final config in _configs) {
        infos.add(await config.toILPInfo());
      }
    }
    if (layers == null) {
      layers = [];
      for (final config in _configs) {
        layers.add(await config.layer.toLayer(true));
      }
    }
    assert(infos.length == layers.length);
    for (var i = 0; i < infos.length; i++) {
      final info = infos[i];
      info.id = i.toString();
      final layer = layers[i];
      final infoBytes = _gzipEncoder.encode(info.writeToBuffer())!;
      final layerBytes = _gzipEncoder.encode(layer.writeToBuffer())!;
      header
        ..infoList.add(infoBytes.length)
        ..layerList.add(layerBytes.length);
      infoList.addAll(infoBytes);
      layerList.addAll(layerBytes);
    }

    final headerBytes = _gzipEncoder.encode(header.writeToBuffer())!;

    final builder = BytesBuilder();

    builder.add(ilpFileFixedStrings);

    builder.add(intTo4Bytes(headerBytes.length));

    builder.add(headerBytes);
    builder.add(infoList);
    builder.add(layerList);
    return builder.toBytes();
  }
}

class ILP {
  final _ILPDataSource _source;

  ILP._(this._source);

  ILPType get type => _source.type;

  Future<bool> get isILP => _source.isILP;

  Future<bool> get isList => _source.isList;

  Future<ILPHeader> get header => _source.header;

  Future<Uint8List> get cover async {
    final h = await header;
    if (h.hasCover()) return _gzipDecoder.decodeBytes(h.cover) as Uint8List;
    return info(0).then((info) => info.cover as Uint8List);
  }

  Future<ILPInfo> info(int index) => _source.info(index);

  Future<List<ILPInfo>> get infos => _source.infos;

  Future<ILPLayer> layer(int index) => _source.layer(index);

  Future<String> get sha1 => _source.sha1;

  Future<String> get md5 => _source.md5;

  Future<int> get length => _source.length;

  List<ILPInfoConfig> get configs => (_source as _ILPConfig)._configs;

  factory ILP.fromFileSync(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw ILPConfigException(message: 'ilp_file_not_exists', file: path);
    }
    return ILP._(_ILPFile(file));
  }

  static Future<ILP> fromFile(String path) async {
    final file = File(path);
    if (!(await file.exists())) {
      throw ILPConfigException(message: 'ilp_file_not_exists', file: path);
    }
    return ILP._(_ILPFile(file));
  }

  factory ILP.fromConfigFiles(List<String> path) {
    final files = path.map((e) => File(e)).toList();
    for (var file in files) {
      if (!file.existsSync()) {
        throw ILPConfigException(
          message: 'ilp_file_not_exists',
          file: file.path,
        );
      }
    }
    return ILP._(_ILPConfig(files));
  }

  factory ILP.fromBytes(Uint8List bytes) => ILP._(_ILPBytes(bytes));

  Future<Uint8List> toBytes({
    required String author,
    required String name,
    int version = 1,
    String? description,
    String? coverFilePath,
    List<String>? links,
    List<ILPInfo>? infos,
    List<ILPLayer>? layers,
  }) {
    assert(type == ILPType.configFiles);
    return (_source as _ILPConfig).toBytes(
      author: author,
      name: name,
      description: description,
      links: links,
      infos: infos,
      layers: layers,
      coverFilePath: coverFilePath,
      version: version,
    );
  }
}
