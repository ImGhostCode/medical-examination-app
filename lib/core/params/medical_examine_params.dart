class LoadSignalParams {
  final List<SignalParamItem> loadSignalParams;
  final String token;
  const LoadSignalParams({
    required this.loadSignalParams,
    required this.token,
  });

  List<Map<String, dynamic>> toMap() {
    return loadSignalParams
        .map((e) => {
              'code': e.code,
              'encounter': e.encounter,
            })
        .toList();
  }
}

class SignalParamItem {
  final String code;
  final String encounter;

  SignalParamItem({
    required this.code,
    required this.encounter,
  });
}

class GetEnteredSignalParams {
  final String type;
  final String encounter;
  final String token;
  const GetEnteredSignalParams({
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

class GetEnteredStreamentSheetParams {
  final String type;
  final String encounter;
  final String token;
  const GetEnteredStreamentSheetParams({
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

class GetEnteredCareSheetParams {
  final String type;
  final String encounter;
  final String token;
  const GetEnteredCareSheetParams({
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
