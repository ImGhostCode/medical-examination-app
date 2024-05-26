abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});

  get accessToken => null;
}

class ServerFailure extends Failure {
  ServerFailure(
      {required String code,
      required super.errorMessage,
      required String status});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}
