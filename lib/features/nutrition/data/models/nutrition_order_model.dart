import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_model.dart';

class NutritionOrderModel extends NutritionOrderEntity {
  NutritionOrderModel({
    super.id,
    super.name,
    super.unit,
    super.gender,
    super.status,
    super.service,
    super.subject,
    super.creators,
    super.division,
    super.quantity,
    super.birthdate,
    super.encounter,
    super.divisionId,
    super.location,
    super.birthDate,
    super.genderName,
    super.nutrition,
    super.nutritionOrderId,
  });

  factory NutritionOrderModel.fromJson({required Map<String, dynamic> json}) {
    return NutritionOrderModel(
      id: json[kId],
      name: json[kName],
      unit: json[kUnit],
      gender: json[kGender],
      status: json[kStatus],
      service: json[kService],
      subject: json[kSubject],
      creators: json[kCreators],
      division: json[kDivision],
      quantity: json[kQuantity],
      birthdate: json[kBirthdate],
      encounter: json[kEncounter],
      divisionId: json[kDivisionId],
      location: json[kLocation]
          .map<LocationModel>((e) => LocationModel.fromJson(json: e))
          .toList(),
      birthDate: json[kBirthDate],
      nutrition: json[kNutrition],
      nutritionOrderId: json[kNutritionOrderId],
      genderName: json[kGenderName],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: super.id,
      kName: super.name,
      kUnit: super.unit,
      kGender: super.gender,
      kStatus: super.status,
      kService: super.service,
      kSubject: super.subject,
      kCreators: super.creators,
      kDivision: super.division,
      kQuantity: super.quantity,
      kBirthdate: super.birthdate,
      kEncounter: super.encounter,
      kDivisionId: super.divisionId,
      kLocation: (super.location as List<LocationModel>)
          .map((e) => e.toJson())
          .toList(),
      kBirthDate: super.birthDate,
      kNutrition: super.nutrition,
      kNutritionOrderId: super.nutritionOrderId,
      kGenderName: super.genderName
    };
  }
}
