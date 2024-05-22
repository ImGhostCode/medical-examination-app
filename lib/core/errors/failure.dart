abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});

  get accessToken => null;
}

class ServerFailure extends Failure {
  ServerFailure({required int statusCode, required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}
