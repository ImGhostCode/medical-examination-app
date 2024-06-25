import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';

class NutritionOrderEntity {
  int? id;
  String? name;
  String? gender;
  String? subject;
  List<LocationEntity>? location;
  String? birthDate;
  int? encounter;
  String? nutrition;
  String? genderName;
  int? nutritionOrderId;
  String? unit;
  String? status;
  String? service;
  String? creators;
  String? division;
  int? quantity;
  String? birthdate;
  int? divisionId;
  bool isSelected = false;

  NutritionOrderEntity(
      {this.id,
      this.name,
      this.unit,
      this.gender,
      this.status,
      this.service,
      this.subject,
      this.creators,
      this.division,
      this.quantity,
      this.birthdate,
      this.encounter,
      this.divisionId,
      this.location,
      this.isSelected = false,
      this.birthDate,
      this.genderName,
      this.nutrition,
      this.nutritionOrderId});
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

                {
            "name": "Nay 18",
            "gender": "male",
            "subject": "24025302",
            "location": [
                {
                    "code": "582b7dc3-ab5d-479b-a298-087ea2fb63c1",
                    "value": 1125358,
                    "display": "Giường 10"
                }
            ],
            "birthdate": "2002",
            "encounter": 24000656,
            "nutrition": "CHÁO THỊT (BT02_M)",
            "gender_name": "Nam",
            "nutrition_order_id": 331
        }
*/