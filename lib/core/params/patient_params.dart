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

class PublishPatientServiceParams {
  String type;
  int encounter;
  int doctor;
  List<PublishPatientServiceItem> items;
  String note;
  String token;

  PublishPatientServiceParams({
    required this.type,
    required this.encounter,
    required this.token,
    required this.doctor,
    required this.note,
    required this.items,
  });
}

class PublishPatientServiceItem {
  int refIdx;
  String code;
  int seq;
  int ordinal;
  int? encounter;
  String? unit;
  String? valueString;
  String? classify;

  PublishPatientServiceItem({
    required this.refIdx,
    required this.code,
    required this.seq,
    required this.ordinal,
    this.encounter,
    this.unit,
    this.valueString,
    this.classify,
  });
}
