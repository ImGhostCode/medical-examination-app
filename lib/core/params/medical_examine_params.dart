import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';

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

class ModifySignalParams {
  final SignalEntity data;
  final int encounter;
  final int? request;
  final String? division;
  final String code;
  final String ip;
  final String token;
  const ModifySignalParams({
    required this.data,
    required this.token,
    required this.ip,
    required this.code,
    required this.encounter,
    this.request,
    this.division,
  });
}

class CreateStreatmentSheetParams {
  final StreatmentSheetEntity data;
  final String division;
  final String token;
  final String ip;
  final String code;
  const CreateStreatmentSheetParams({
    required this.token,
    required this.ip,
    required this.code,
    required this.data,
    required this.division,
  });
}

class EditStreatmentSheetParams {
  final StreatmentSheetEntity data;
  final int request;
  final String token;
  final String ip;
  final String code;
  const EditStreatmentSheetParams({
    required this.token,
    required this.ip,
    required this.code,
    required this.data,
    required this.request,
  });
}

class CreateCareSheetParams {
  final CareSheetEntity data;
  final String division;
  final String token;
  final String ip;
  final String code;
  const CreateCareSheetParams({
    required this.token,
    required this.ip,
    required this.code,
    required this.data,
    required this.division,
  });
}

class EditCareSheetParams {
  final CareSheetEntity data;
  final int request;
  final String token;
  final String ip;
  final String code;
  const EditCareSheetParams({
    required this.token,
    required this.ip,
    required this.code,
    required this.data,
    required this.request,
  });
}

class PublishMedicalSheetParams {
  final int encounter;
  final String id;
  final String type;
  final int doctor;
  final String token;
  final String ip;
  final String code;
  const PublishMedicalSheetParams({
    required this.token,
    required this.ip,
    required this.code,
    required this.encounter,
    required this.id,
    required this.type,
    required this.doctor,
  });
}
