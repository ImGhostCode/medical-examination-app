class GetNutritionParams {
  String key;
  String token;

  GetNutritionParams({required this.key, required this.token});
}

// {"status":"all","org":"all","from":"2024-03-23 00:00:00","to":"2024-03-23 23:59:59"}
class GetNutritionOrderParams {
  String token;
  String status;
  dynamic org;
  String from;
  String to;

  GetNutritionOrderParams(
      {required this.token,
      required this.status,
      required this.org,
      required this.from,
      required this.to});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'org': org,
      'from': from,
      'to': to,
    };
  }
}
