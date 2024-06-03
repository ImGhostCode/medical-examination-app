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
