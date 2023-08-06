## 1.0.14

- Fixed an issue where the `ILP.fromFile` method would lock the file if parsed incorrectly.

## 1.0.13

- ILP.toBytes({int version=1}) add 'version' parameter.

## 1.0.12+1

- Fixed readme.md error

## 1.0.12

- `ILP.fromFile(String path)` renamed to `ILP.fromFileSync(String path)`
- add `Future<ILP> ILP.fromFile(String path)` method
- add about ILP.fromFile exceptions

## 1.0.11

- Add ILPConfigException, and list all exception codes at readme.md

## 1.0.10

- ILPInfoConfig add `Future<bool> validate()` method, it tested the info and layers files exist or not.
- ILPLayerConfig add `Future<bool> validate()` method, it tested self and children layers files exist or not.
- ILPLayerConfig add `List<ILPLayerConfig> contentLayers` method, return children content layers(included file).

## 1.0.9

- renamed ILPConfig to ILPInfoConfig and exported it
- renamed ILPInfoConfig\.layers to ILPInfoConfig\.layer
- renamed ILPInfoConfig\.layers to ILPInfoConfig\.layer
- fixed ILP.cover and `ILP.toBytes({String? coverFilePath})` issues
- add ILPInfo\.id ILPLayer\.id
- ILPInfo.contentLayerIdList instead of the.ILPInfo.layerCount

## 1.0.8

- implemented the _ILPConfig\.header and _ILPConfig\._headerLength
- fixed unit test

## 1.0.7+3

- `ILPConfig.toJson(Map data)` changed to `ILPConfig.toJson(Map data, {String? name})`

## 1.0.7+2

- use `package:archive` instead of `dart:io`

## 1.0.7+1

- use `package:universal_io` instead of `dart:io`

## 1.0.7

- add ILP.md5, ILP.sha1, ILP.length methods.

## 1.0.6

- ILP add .fromBytes method
- ILP.infos() change to ILP.infos

## 1.0.5

- ILPInfo and ILPLayer add a field for name

## 1.0.4+1

- Downgrade the collection package version

## 1.0.4

- remove Sponsor, use string

## 1.0.3

- ILPInfo add infos
- ILPInfo add layerCount

## 1.0.2

- ILP support list

## 1.0.1

- ILP add list type

## 1.0.0+2

- fix ilp\.dart

## 1.0.0+1

- Downgrade the collection package version to ^1.17.0

## 1.0.0

- Initial version.
