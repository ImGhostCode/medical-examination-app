class UserEntity {
  final int id;
  final String code;
  final String work;
  final String token;
  final String display;
  final String expired;
  final String userName;
  final bool isChangeNow;
  final List<FunctionEntity> functions;
  final OrganizationEntity organization;
  const UserEntity({
    required this.id,
    required this.code,
    required this.work,
    required this.token,
    required this.display,
    required this.expired,
    required this.userName,
    required this.isChangeNow,
    required this.functions,
    required this.organization,
  });
}

class OrganizationEntity {
  final String code;
  final int value;
  final String display;
  const OrganizationEntity({
    required this.code,
    required this.value,
    required this.display,
  });
}

class FunctionEntity {
  final String code;
  final bool allow;
  final bool fDefault;
  final String display;
  const FunctionEntity({
    required this.code,
    required this.allow,
    required this.fDefault,
    required this.display,
  });
}
