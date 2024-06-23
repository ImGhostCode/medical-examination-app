abstract class Failure {
  final String errorMessage;
  final String? hints;
  const Failure({required this.errorMessage, this.hints = ''});

  get accessToken => null;
}

class ServerFailure extends Failure {
  ServerFailure(
      {required String code,
      required super.errorMessage,
      super.hints = '',
      required String status});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}
