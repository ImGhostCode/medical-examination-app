class ServerException implements Exception {
  final String code;
  final String status;
  final String message;

  ServerException(
      {required this.code, required this.status, required this.message});
}

class CacheException implements Exception {}
