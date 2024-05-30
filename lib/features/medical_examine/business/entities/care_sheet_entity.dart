class CareSheetEntity {
  String? id;
  String? type;
  int? encounter;
  int? subject;
  int? request;
  dynamic doctor;
  String? status;
  String? created;
  List<CareSheetItemEntity>? value;

  CareSheetEntity(
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

class CareSheetItemEntity {
  String code;
  List<String> value;

  CareSheetItemEntity({required this.code, required this.value});
}

/*
{
            "id": "01099ee4-be90-4282-935c-46d198d697ae",
            "value": [
                {
                    "code": "VST_0006",
                    "value": [
                        "y lệnh chăm sóc"
                    ]
                },
                {
                    "code": "VST_0005",
                    "value": [
                        "theo dõi diễn biến"
                    ]
                }
            ],
            "doctor": "Bs Nguyễn Tấn Tài",
            "status": "draft",
            "created": "2024-03-25 14:55:25",
            "encounter": 24000687
        },
*/