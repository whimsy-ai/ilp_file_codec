# Image Layers Package(.ilp) file codec

<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

This package is the .ilp file codec.

## Work flows

1. Use [the Photoshop plugin](https://github.com/whimsy-ai/ilp_photoshop_plugin) to export the config.json and some
   images
   files.
2. Use ILP encoder encode the config.json to .ilp file.
3. Use ILP decoder decode the .ilp file to data.

## The .ilp file structure

| Part | Range           | Length           | Bytes Content                 | Gzip | Desc                                                                                             |
|------|-----------------|------------------|-------------------------------|------|--------------------------------------------------------------------------------------------------|
| A    | 0 ~ 3           | 4                | [0x49, 0x4c, 0x50, 0x21]      |      | Fixed file strings. <br/>convert to utf8 is: ILP!                                                |
| B    | 4 ~ 7           | 4                | int32 value                   |      | Protobuf ILPHeader bytes length                                                                  |
| C    | 8 ~ 8+C         | Part B int value | Protobuf ILPHeader bytes      | ✔    | Check out [protobuf](https://github.com/whimsy-ai/ilp_file_codec/blob/master/protobuf/ilp.proto) |
| D    | 8+C+1 ~ dynamic | dynamic          | Protobuf ILPInfo(List) bytes  | ✔    | Check out [protobuf](https://github.com/whimsy-ai/ilp_file_codec/blob/master/protobuf/ilp.proto) |
| E    | dynamic ~ end   | dynamic          | Protobuf ILPLayer(List) bytes | ✔    | Check out [protobuf](https://github.com/whimsy-ai/ilp_file_codec/blob/master/protobuf/ilp.proto) |

## Usage

Check out the [test/ilp_codec_test.dart](https://github.com/whimsy-ai/ilp_file_codec/test/ilp_codec_test.dart) file.

## Exception Codes

| Entity         | Code                      | Content                                               |
|:---------------|---------------------------|-------------------------------------------------------|
| ILP            | ilp_file_not_exists       | ilp file not exists                                   |
|                | ilp_file_parse_error      | decoder can't parse the ilp file content              |
| ILPInfoConfig  | info_file_not_exists      | info config file not exists                           |
|                | info_file_not_string_file | info config file not a string file                    |
|                | info_file_parse_error     | info file content can not parse to json data          |
|                | info_missing_width        | missing the width field                               |
|                | info_missing_height       | missing the height field                              |
|                | info_missing_cover        | missing the cover field                               |
|                | info_cover_not_exists     | cover file not exists                                 |
|                | info_missing_layers       | missing the layers field                              |
| ILPLayerConfig | layer_no_file             | when get the layer group id will throw this exception |
|                | layer_missing_width       | missing the width field                               |
|                | layer_missing_height      | missing the height field                              |
|                | layer_missing_x           | missing the x field                                   |
|                | layer_missing_y           | missing the y field                                   |
|                | layer_missing_file        | missing the file field                                |
|                | layer_file_not_exists     | layer file not exists                                 |

## Before run the test

* Requirement: Open test.psd and use the Photoshop plugin export the files to the test folder.

* Optional: Run the command to generate protobuf dart side code:

    ```
    cd ./ilp_codec
    protoc -I .\protobuf --dart_out=.\lib\protobuf .\protobuf\*.proto
    ```

## [License](LICENSE)