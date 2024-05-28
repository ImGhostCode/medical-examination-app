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