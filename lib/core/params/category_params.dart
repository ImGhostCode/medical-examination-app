class GetDepartmentPrarams {
  String type;
  String kind;
  String token;

  GetDepartmentPrarams(
      {required this.type, required this.kind, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'kind': kind,
    };
  }
}
// {"type":"all","kind":"treatment_role"}

class GetSubclinicServicePrarams {
  String key;
  String token;

  GetSubclinicServicePrarams({required this.key, required this.token});
}

// {"type": "subclinic_group"}
class GetSubclinicServiceGroupPrarams {
  String type;
  String token;

  GetSubclinicServiceGroupPrarams({required this.type, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }
}

class GetEnteredSubclinicServicePrarams {
  String encounter;
  String type;
  String token;

  GetEnteredSubclinicServicePrarams(
      {required this.token, required this.type, required this.encounter});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'encounter': encounter,
    };
  }
}

class GetICDPrarams {
  String key;
  String token;

  GetICDPrarams({required this.token, required this.key});
}
