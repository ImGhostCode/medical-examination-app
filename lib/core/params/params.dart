class NoParams {}

class TemplateParams {}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}

class LoginParams {
  final String rdKey;
  final String user;
  final String password;
  const LoginParams({
    required this.rdKey,
    required this.user,
    required this.password,
  });
}
