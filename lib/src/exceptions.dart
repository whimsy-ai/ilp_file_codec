class ILPConfigException implements Exception {
  /// A message describing the format error.
  final String message;
  String? file;

  ILPConfigException({this.message = '', this.file});
}
