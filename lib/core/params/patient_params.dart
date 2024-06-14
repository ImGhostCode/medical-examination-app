class GetPatientInRoomParams {
  final String location;
  final String status;
  final String from;
  final String to;
  final bool activeNewIp;
  final String? kind;

  final String token;

  GetPatientInRoomParams({
    required this.location,
    required this.status,
    required this.from,
    required this.to,
    required this.activeNewIp,
    this.kind,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'status': status,
      'from': from,
      'to': to,
      'active_new_ip': activeNewIp,
      'kind': kind,
    };
  }
}

// {"location":"29664","status":"active","from":"2024-03-16 00:00:00","to":"2024-03-16 23:59:59","active_new_ip":false,"kind":null}

class GetPatientInfoParams {
  String type;
  int encounter;
  String token;

  GetPatientInfoParams({
    required this.type,
    required this.encounter,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'encounter': encounter,
    };
  }
}

class GetPatientServiceParams {
  String type;
  int encounter;
  String token;

  GetPatientServiceParams({
    required this.type,
    required this.encounter,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'encounter': encounter,
    };
  }
}
