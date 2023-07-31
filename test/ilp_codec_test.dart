import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:ilp_file_codec/ilp_codec.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

void main() async {
  final currentDirectory = Directory.current;
  print('Current directory: ${currentDirectory.path}');
  final configFile = File(path.join(
    currentDirectory.path,
    'test',
    'test_config.json',
  ));
  final testFolderPath = path.join(path.current, 'test');
  final ilpFile = File(path.join(testFolderPath, 'test.ilp'));
  final infoCover = File(path.join(testFolderPath, 'test_0.png'));
  final ilpCover = File(path.join(testFolderPath, 'test_1.png'));
  final infoCoverContent =
      await File(path.join(testFolderPath, 'test_0.png')).readAsBytes();
  final background = File(path.join(testFolderPath, 'test_6.png'));

  final layerFile = path.join(testFolderPath, 'test_1.png');

  final backgroundContent = await background.readAsBytes();

  late ILPInfoConfig config;

  ilpTester(Uint8List bytes, File file) async {
    final ilp1 = ILP.fromBytes(bytes), ilp2 = ILP.fromFileSync(file.path);
    expect((await ilp1.length) == (await file.length()), true);
    expect((await ilp2.length) == (await file.length()), true);

    expect(await ilp1.cover, await ilpCover.readAsBytes());
    expect(await ilp1.cover, await ilp2.cover);

    final header1 = await ilp1.header, header2 = await ilp2.header;

    expect(<int>{2, header1.version, header2.version}, <int>{2});

    expect(header1.id, crypto.sha1.convert(backgroundContent).toString());
    expect(header1.id, header2.id);
    expect(await ilp1.sha1, await ilp2.sha1);
    expect(
        await ilp1.sha1,
        crypto.sha1
            .convert([...header2.infoList, ...header2.layerList]).toString());
    expect(await ilp1.md5, await ilp2.md5);
    expect(
        await ilp1.md5,
        crypto.md5
            .convert([...header2.infoList, ...header2.layerList]).toString());

    final info = await ilp1.info(0);

    expect(info.contentLayerIdList.length, 6);
    expect(
        info.contentLayerIdList.contains(crypto.sha1
            .convert(await File(layerFile).readAsBytes())
            .toString()),
        true);
    expect(info.cover.isNotEmpty, true);
    expect(info.cover, infoCoverContent);
    expect(header1.author, 'gzlock');
    expect(header1.description, 'hi');
    expect(header1.links.first, 'github');
    expect(header1.links.last, 'https://github.com');

    ///
    expect((await ilp1.layer(0)).content, backgroundContent);
    expect((await ilp2.layer(0)).content, backgroundContent);
  }

  /// note: ILPConfig is used internally
  test('ILPConfig test', () async {
    config = await ILPInfoConfig.fromFile(configFile.path);

    expect(await config.validate(), true);
    expect(await config.layer.validate(), true);

    String file = config.cover;
    config.cover = 'not_exists_file.png';
    expect(await config.validate(), false);
    config.cover = file;

    file = config.filePath!;
    config.filePath = 'not_exists_file.json';
    expect(await config.validate(), false);
    config.filePath = file;

    file = config.layer.file!;
    config.layer.file = 'not_exists_file.png';
    expect(await config.layer.validate(), false);
    config.layer.file = file;

    try {
      final layer = config.layer.search('2');
      await layer.first.id;
    } on ILPConfigException catch (e) {
      expect(e.message, 'layer_no_file');
    }

    expect(config.filePath, configFile.path);
    expect(config.name, 'test_config');
    expect(config.layer.name, 'background');

    /// 2 layers named 5 (1 group, 1 layer)
    expect(config.layer.search('5').length, 2);

    /// no layer named 7 (hidden)
    expect(config.layer.search('7').length, 0);

    /// no empty layers
    expect(config.layer.search('empty').length, 0);

    /// no hidden layers
    expect(config.layer.search('hidden').length, 0);

    expect(config.cover, infoCover.path);
    expect(config.layer.file!, background.path);
  });

  group('Single ILP config file encoder test', () {
    late Uint8List bytes;
    test('encoder test', () async {
      final ilp = ILP.fromConfigFiles([configFile.path]);
      final infos = await ilp.infos;
      infos.first.name = 'first info';
      bytes = await ilp.toBytes(
        name: 'test',
        author: 'gzlock',
        description: 'hi',
        links: ['github', 'https://github.com'],
        infos: infos,
        coverFilePath: ilpCover.path,
        version: 2,
      );
      expect(bytes.sublist(0, 4), ilpFileFixedStrings);

      await ilpFile.writeAsBytes(bytes);
    });
    test('decoder test', () async {
      await ilpTester(bytes, ilpFile);
      final ilp = ILP.fromBytes(bytes);
      expect(await ilp.isList, false);
    });
  });

  group('Multiple ILP config files encoder test', () {
    late Uint8List bytes;
    test('encoder test', () async {
      final ilp = ILP.fromConfigFiles([configFile.path, configFile.path]);
      final infos = await ilp.infos;
      infos.first.name = 'first info';
      infos.last.name = 'last info';
      bytes = await ilp.toBytes(
        name: 'test',
        author: 'gzlock',
        description: 'hi',
        links: ['github', 'https://github.com'],
        infos: infos,
        coverFilePath: ilpCover.path,
        version: 2,
      );
      expect(bytes.sublist(0, 4), ilpFileFixedStrings);

      await ilpFile.writeAsBytes(bytes);
    });

    test('decoder test', () async {
      await ilpTester(bytes, ilpFile);
      final ilp = ILP.fromBytes(bytes);
      expect(await ilp.isList, true);
    });
  });

  group('utils tester', () {
    test('ILP exception', () {
      try {
        ILP.fromFileSync('ilp_not_exists');
      } on ILPConfigException catch (e) {
        expect(e.message, 'ilp_file_not_exists');
      }
    });
  });
}
