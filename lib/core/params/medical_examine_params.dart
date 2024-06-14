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

class SubclinicServDesignationParams {
  String status;
  int doctor;
  List<ServiceParams> services;
  int encounter;
  int subject;
  ReasonParams reason;
  int request;
  String note;
  int rate;
  bool isPublish;

  String token;
  String ip;
  String code;

  SubclinicServDesignationParams({
    required this.status,
    required this.doctor,
    required this.services,
    required this.encounter,
    required this.subject,
    required this.reason,
    required this.request,
    required this.note,
    required this.rate,
    required this.isPublish,
    required this.token,
    required this.ip,
    required this.code,
  });
}

class ServiceParams {
  String code;
  int quantity;
  String type;
  String isCard;
  bool emergency;
  List<String> option;
  String start;

  ServiceParams({
    required this.code,
    required this.quantity,
    required this.type,
    required this.isCard,
    required this.emergency,
    required this.option,
    required this.start,
  });
}

class ReasonParams {
  Reason reason;
  List<NewIcds> newIcds;

  ReasonParams({
    required this.reason,
    required this.newIcds,
  });
}

class Reason {
  String text;
  List<String> value;

  Reason({
    required this.text,
    required this.value,
  });
}

class NewIcds {
  String code;
  String type;

  NewIcds({
    required this.code,
    required this.type,
  });
}

/* SubclinicServDesignationParams
{
        "status": "new",
        "doctor": 16631,
        "services": [
            {
                "code": "1116352",
                "quantity": 1,
                "type": "fee",
                "is_card": "on",
                "emergency": false,
                "option": [],
                "start": ""
            }
        ],
        "encounter": 23088696,
        "subject": 23046872,
        "reason": {
            "reason": {
                "text": "Bệnh thương hàn và phó thương hàn",
                "value": [
                    "A01"
                ]
            },
            "new_icds": [
                {
                    "code": "A01",
                    "type": "SU"
                }
            ]
        },
        "request": 29664,
        "note": "Mô tả",
        "rate": 80,
        "is_publish": true
    },
*/