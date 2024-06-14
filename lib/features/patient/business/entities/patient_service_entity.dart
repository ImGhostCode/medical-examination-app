class PatientServiceEntity {
  String id;
  String type;
  String? owner;
  int price;
  String status;
  String? creators;
  String service;

  PatientServiceEntity({
    required this.id,
    required this.type,
    this.owner,
    required this.price,
    required this.status,
    this.creators,
    required this.service,
  });
}
