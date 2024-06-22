import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';

class NutritionOrderModel extends NutritionOrderEntity {
  NutritionOrderModel(
      {required super.id,
      required super.name,
      required super.unit,
      required super.gender,
      required super.status,
      required super.service,
      required super.subject,
      required super.creators,
      required super.division,
      required super.quantity,
      required super.birthdate,
      required super.encounter,
      required super.divisionId});

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
    };
  }
}
