class StreatmentSheetEntity {
  String? id;
  String? type;
  int? encounter;
  int? subject;
  int? request;
  dynamic doctor;
  String? status;
  String? created;
  List<StreatmentSheetItemEntity>? value;

  StreatmentSheetEntity(
      {this.id,
      this.type,
      this.encounter,
      this.subject,
      this.request,
      this.doctor,
      this.value,
      this.created,
      this.status});
}

class StreatmentSheetItemEntity {
  String code;
  List<String> value;

  StreatmentSheetItemEntity({required this.code, required this.value});
}


/*
 {
        "type": "OET_002",
        "encounter": 24000687,
        "subject": 24025333,
        "request": 29664,
        "doctor": 16631,
        "items": [
            {
                "code": "VST_0005",
                "value": [
                    "{{VST_0005}}"
                ]
            },
            {
                "code": "VST_0006",
                "value": [
                    "{{VST_0006}}"
                ]
            }
        ]
    }
*/