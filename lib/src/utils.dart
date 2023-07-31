import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:universal_io/io.dart';

import '../ilp_codec.dart';

bool isILPFile(List<int> data) {
  if (data.length < ilpFileFixedStrings.length) {
    return false;
  } else if (data.length == (ilpFileFixedStringsLength + 5)) {
    return ListEquality().equals(data, ilpFileFixedStrings);
  }
  return ListEquality().equals(
    data.take(ilpFileFixedStrings.length).toList(),
    ilpFileFixedStrings,
  );
}

Uint8List intTo4Bytes(int val) {
  final bytes = Uint8List(4);
  final bd = ByteData.view(bytes.buffer);
  bd.setUint32(0, val);
  return bytes;
}

Uint8List boolToBytes(bool val) => Uint8List(1)..first = val ? 1 : 0;

bool boolFromBytes(Uint8List bytes) => bytes.first == 1;

Future<String> fileSha1(File file) => file.readAsBytes().then(bytesSha1);

String bytesSha1(Uint8List bytes) => crypto.sha1.convert(bytes).toString();
