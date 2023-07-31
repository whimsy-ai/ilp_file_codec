//
//  Generated code. Do not modify.
//  source: ilp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use iLPHeaderDescriptor instead')
const ILPHeader$json = {
  '1': 'ILPHeader',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'version', '3': 5, '4': 1, '5': 13, '10': 'version'},
    {'1': 'links', '3': 6, '4': 3, '5': 9, '10': 'links'},
    {'1': 'skip', '3': 7, '4': 1, '5': 8, '10': 'skip'},
    {'1': 'random', '3': 8, '4': 1, '5': 8, '10': 'random'},
    {'1': 'infoList', '3': 9, '4': 3, '5': 13, '10': 'infoList'},
    {'1': 'layerList', '3': 10, '4': 3, '5': 13, '10': 'layerList'},
    {'1': 'cover', '3': 11, '4': 1, '5': 12, '10': 'cover'},
  ],
};

/// Descriptor for `ILPHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iLPHeaderDescriptor = $convert.base64Decode(
    'CglJTFBIZWFkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSFgoGYXV0aG'
    '9yGAMgASgJUgZhdXRob3ISIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhgKB3Zl'
    'cnNpb24YBSABKA1SB3ZlcnNpb24SFAoFbGlua3MYBiADKAlSBWxpbmtzEhIKBHNraXAYByABKA'
    'hSBHNraXASFgoGcmFuZG9tGAggASgIUgZyYW5kb20SGgoIaW5mb0xpc3QYCSADKA1SCGluZm9M'
    'aXN0EhwKCWxheWVyTGlzdBgKIAMoDVIJbGF5ZXJMaXN0EhQKBWNvdmVyGAsgASgMUgVjb3Zlcg'
    '==');

@$core.Deprecated('Use iLPInfoDescriptor instead')
const ILPInfo$json = {
  '1': 'ILPInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
    {'1': 'cover', '3': 5, '4': 1, '5': 12, '10': 'cover'},
    {'1': 'skip', '3': 6, '4': 1, '5': 8, '10': 'skip'},
    {'1': 'contentLayerIdList', '3': 7, '4': 3, '5': 9, '10': 'contentLayerIdList'},
  ],
};

/// Descriptor for `ILPInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iLPInfoDescriptor = $convert.base64Decode(
    'CgdJTFBJbmZvEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXdpZHRoGA'
    'MgASgFUgV3aWR0aBIWCgZoZWlnaHQYBCABKAVSBmhlaWdodBIUCgVjb3ZlchgFIAEoDFIFY292'
    'ZXISEgoEc2tpcBgGIAEoCFIEc2tpcBIuChJjb250ZW50TGF5ZXJJZExpc3QYByADKAlSEmNvbn'
    'RlbnRMYXllcklkTGlzdA==');

@$core.Deprecated('Use iLPLayerDescriptor instead')
const ILPLayer$json = {
  '1': 'ILPLayer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'x', '3': 3, '4': 1, '5': 5, '10': 'x'},
    {'1': 'y', '3': 4, '4': 1, '5': 5, '10': 'y'},
    {'1': 'width', '3': 5, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 6, '4': 1, '5': 5, '10': 'height'},
    {'1': 'content', '3': 7, '4': 1, '5': 12, '10': 'content'},
    {'1': 'layers', '3': 8, '4': 3, '5': 11, '6': '.ilp.ILPLayer', '10': 'layers'},
  ],
};

/// Descriptor for `ILPLayer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iLPLayerDescriptor = $convert.base64Decode(
    'CghJTFBMYXllchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIMCgF4GAMgAS'
    'gFUgF4EgwKAXkYBCABKAVSAXkSFAoFd2lkdGgYBSABKAVSBXdpZHRoEhYKBmhlaWdodBgGIAEo'
    'BVIGaGVpZ2h0EhgKB2NvbnRlbnQYByABKAxSB2NvbnRlbnQSJQoGbGF5ZXJzGAggAygLMg0uaW'
    'xwLklMUExheWVyUgZsYXllcnM=');

