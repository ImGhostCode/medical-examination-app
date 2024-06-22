class NutritionOrderEntity {
  int id;
  String name;
  String unit;
  String gender;
  String status;
  String service;
  int subject;
  String creators;
  String division;
  int quantity;
  String birthdate;
  int encounter;
  int divisionId;

  NutritionOrderEntity({
    required this.id,
    required this.name,
    required this.unit,
    required this.gender,
    required this.status,
    required this.service,
    required this.subject,
    required this.creators,
    required this.division,
    required this.quantity,
    required this.birthdate,
    required this.encounter,
    required this.divisionId,
  });
}

/*
        {
            "id": 373,
            "name": "Hoài Lê",
            "unit": "ngày",
            "gender": "male",
            "status": "approve",
            "service": "CHÁO THỊT (BT02_M)",
            "subject": 24025481,
            "creators": "2024-03-23 - Phan Chánh Hưng",
            "division": "Khoa Cấp tính Nam",
            "quantity": 1,
            "birthdate": "1999",
            "encounter": 24000813,
            "division_id": 29586
        },
*/