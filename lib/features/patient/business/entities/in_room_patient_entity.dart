class InRoomPatientEntity {
  String code;
  String name;
  String start;
  String gender;
  int subject;
  String birthdate;
  int encounter;
  String? feeObject;
  String? classifyCode;
  String? classifyName;
  String processingStatus;
  bool isSelected = false;

  InRoomPatientEntity({
    required this.code,
    required this.name,
    required this.start,
    required this.gender,
    required this.subject,
    required this.birthdate,
    required this.encounter,
    this.feeObject,
    this.classifyCode,
    this.classifyName,
    required this.processingStatus,
    this.isSelected = false,
  });
}

/*
  {
    "code": "a00d9151-dd7b-4d72-85ea-f92f00c7e00c",
    "name": "Có Cj Đâu À Heeee",
    "start": "2024-03-16T07:56:44.239845",
    "gender": "male",
    "subject": 24025298,
    "birthdate": "1999",
    "encounter": 24000652,
    "fee_object": "free",
    "classify_code": "ECL_26",
    "classify_name": "Bệnh án nội trú ban ngày",
    "processing_status": "med_request"
  }
*/