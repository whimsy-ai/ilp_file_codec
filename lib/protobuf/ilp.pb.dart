//
//  Generated code. Do not modify.
//  source: ilp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ILPHeader extends $pb.GeneratedMessage {
  factory ILPHeader() => create();
  ILPHeader._() : super();
  factory ILPHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ILPHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ILPHeader', package: const $pb.PackageName(_omitMessageNames ? '' : 'ilp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..pPS(6, _omitFieldNames ? '' : 'links')
    ..aOB(7, _omitFieldNames ? '' : 'skip')
    ..aOB(8, _omitFieldNames ? '' : 'random')
    ..p<$core.int>(9, _omitFieldNames ? '' : 'infoList', $pb.PbFieldType.KU3, protoName: 'infoList')
    ..p<$core.int>(10, _omitFieldNames ? '' : 'layerList', $pb.PbFieldType.KU3, protoName: 'layerList')
    ..a<$core.List<$core.int>>(11, _omitFieldNames ? '' : 'cover', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ILPHeader clone() => ILPHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ILPHeader copyWith(void Function(ILPHeader) updates) => super.copyWith((message) => updates(message as ILPHeader)) as ILPHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ILPHeader create() => ILPHeader._();
  ILPHeader createEmptyInstance() => create();
  static $pb.PbList<ILPHeader> createRepeated() => $pb.PbList<ILPHeader>();
  @$core.pragma('dart2js:noInline')
  static ILPHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ILPHeader>(create);
  static ILPHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get links => $_getList(5);

  @$pb.TagNumber(7)
  $core.bool get skip => $_getBF(6);
  @$pb.TagNumber(7)
  set skip($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSkip() => $_has(6);
  @$pb.TagNumber(7)
  void clearSkip() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get random => $_getBF(7);
  @$pb.TagNumber(8)
  set random($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRandom() => $_has(7);
  @$pb.TagNumber(8)
  void clearRandom() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.int> get infoList => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<$core.int> get layerList => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<$core.int> get cover => $_getN(10);
  @$pb.TagNumber(11)
  set cover($core.List<$core.int> v) { $_setBytes(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCover() => $_has(10);
  @$pb.TagNumber(11)
  void clearCover() => clearField(11);
}

class ILPInfo extends $pb.GeneratedMessage {
  factory ILPInfo() => create();
  ILPInfo._() : super();
  factory ILPInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ILPInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ILPInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'ilp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'height', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'cover', $pb.PbFieldType.OY)
    ..aOB(6, _omitFieldNames ? '' : 'skip')
    ..pPS(7, _omitFieldNames ? '' : 'contentLayerIdList', protoName: 'contentLayerIdList')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ILPInfo clone() => ILPInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ILPInfo copyWith(void Function(ILPInfo) updates) => super.copyWith((message) => updates(message as ILPInfo)) as ILPInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ILPInfo create() => ILPInfo._();
  ILPInfo createEmptyInstance() => create();
  static $pb.PbList<ILPInfo> createRepeated() => $pb.PbList<ILPInfo>();
  @$core.pragma('dart2js:noInline')
  static ILPInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ILPInfo>(create);
  static ILPInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get height => $_getIZ(3);
  @$pb.TagNumber(4)
  set height($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get cover => $_getN(4);
  @$pb.TagNumber(5)
  set cover($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get skip => $_getBF(5);
  @$pb.TagNumber(6)
  set skip($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSkip() => $_has(5);
  @$pb.TagNumber(6)
  void clearSkip() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get contentLayerIdList => $_getList(6);
}

class ILPLayer extends $pb.GeneratedMessage {
  factory ILPLayer() => create();
  ILPLayer._() : super();
  factory ILPLayer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ILPLayer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ILPLayer', package: const $pb.PackageName(_omitMessageNames ? '' : 'ilp'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'y', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'height', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..pc<ILPLayer>(8, _omitFieldNames ? '' : 'layers', $pb.PbFieldType.PM, subBuilder: ILPLayer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ILPLayer clone() => ILPLayer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ILPLayer copyWith(void Function(ILPLayer) updates) => super.copyWith((message) => updates(message as ILPLayer)) as ILPLayer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ILPLayer create() => ILPLayer._();
  ILPLayer createEmptyInstance() => create();
  static $pb.PbList<ILPLayer> createRepeated() => $pb.PbList<ILPLayer>();
  @$core.pragma('dart2js:noInline')
  static ILPLayer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ILPLayer>(create);
  static ILPLayer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get x => $_getIZ(2);
  @$pb.TagNumber(3)
  set x($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get y => $_getIZ(3);
  @$pb.TagNumber(4)
  set y($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get width => $_getIZ(4);
  @$pb.TagNumber(5)
  set width($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWidth() => $_has(4);
  @$pb.TagNumber(5)
  void clearWidth() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get height => $_getIZ(5);
  @$pb.TagNumber(6)
  set height($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHeight() => $_has(5);
  @$pb.TagNumber(6)
  void clearHeight() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get content => $_getN(6);
  @$pb.TagNumber(7)
  set content($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasContent() => $_has(6);
  @$pb.TagNumber(7)
  void clearContent() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<ILPLayer> get layers => $_getList(7);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
