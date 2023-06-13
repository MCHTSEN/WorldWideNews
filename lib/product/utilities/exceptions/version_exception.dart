class VersionException implements Exception {
  VersionException(this.message);

  final String message;

  @override
  String toString() {
    // TODO: implement toString
    return '$this $message';
  }
}
