class ServerException implements Exception {
  final String code;
  final String status;
  final String message;
  final String? hints;

  ServerException(
      {required this.code,
      required this.status,
      required this.message,
      this.hints = ''});
}

class CacheException implements Exception {}
