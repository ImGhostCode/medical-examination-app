import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';

class CareSheetModel extends CareSheetEntity {
  CareSheetModel(
      {super.id,
      super.type,
      super.doctor,
      super.encounter,
      super.request,
      super.subject,
      super.value,
      super.created,
      super.status});

  factory CareSheetModel.fromJson({required Map<String, dynamic> json}) {
    return CareSheetModel(
      id: json[kId],
      type: json[kType],
      doctor: json[kDoctor],
      encounter: json[kEncounter],
      request: json[kRequest],
      subject: json[kSubject],
      value: json[kValue] != null
          ? json[kValue]
              .map<CareSheetItem>((e) => CareSheetItem.fromJson(json: e))
              .toList()
          : [],
      created: json[kCreated],
      status: json[kStatus],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kType: type,
      kDoctor: doctor,
      kEncounter: encounter,
      kRequest: request,
      kSubject: subject,
      kValue: (value as List<CareSheetItem>).map((e) => e.toJson()).toList(),
      kCreated: created,
      kStatus: status,
    };
  }
}

class CareSheetItem extends CareSheetItemEntity {
  CareSheetItem({required super.code, required super.value});

  factory CareSheetItem.fromJson({required Map<String, dynamic> json}) {
    return CareSheetItem(
      code: json[kCode],
      value: json[kValue].map<String>((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kValue: value,
    };
  }
}
