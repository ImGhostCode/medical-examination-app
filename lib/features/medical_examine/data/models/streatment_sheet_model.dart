import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';

class StreatmentSheetModel extends StreatmentSheetEntity {
  StreatmentSheetModel(
      {super.id,
      super.type,
      super.doctor,
      super.encounter,
      super.request,
      super.subject,
      super.value,
      super.created,
      super.status});

  factory StreatmentSheetModel.fromJson({required Map<String, dynamic> json}) {
    return StreatmentSheetModel(
      id: json[kId],
      type: json[kType],
      doctor: json[kDoctor],
      encounter: json[kEncounter],
      request: json[kRequest],
      subject: json[kSubject],
      value: json[kValue] != null
          ? json[kValue]
              .map<StreatmentSheetItem>(
                  (e) => StreatmentSheetItem.fromJson(json: e))
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
      kValue:
          (value as List<StreatmentSheetItem>).map((e) => e.toJson()).toList(),
      kCreated: created,
      kStatus: status,
    };
  }
}

class StreatmentSheetItem extends StreatmentSheetItemEntity {
  StreatmentSheetItem({required super.code, required super.value});

  factory StreatmentSheetItem.fromJson({required Map<String, dynamic> json}) {
    return StreatmentSheetItem(
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
