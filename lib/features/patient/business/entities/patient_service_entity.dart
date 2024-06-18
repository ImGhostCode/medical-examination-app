class PatientServiceEntity {
  String id;
  String type;
  String? owner;
  int price;
  String status;
  String? creators;
  String service;
  String reportCode;
  int quantity;
  String unit;
  String? result;
  bool isSelected;
  int? refIdx;
  int seq;

  PatientServiceEntity(
      {required this.id,
      required this.type,
      this.owner,
      required this.price,
      required this.status,
      this.creators,
      required this.service,
      required this.reportCode,
      required this.quantity,
      required this.unit,
      this.isSelected = false,
      this.refIdx,
      required this.seq,
      this.result});
}
