import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';

class NutritionModel extends NutritionEntity {
  NutritionModel(
      {required super.code,
      required super.unit,
      required super.price,
      required super.report,
      required super.choosed,
      required super.display,
      required super.editQuantity,
      required super.priceRequired,
      required super.priceInsurance,
      super.quantity = 1});

  factory NutritionModel.fromJson({required Map<String, dynamic> json}) {
    return NutritionModel(
      code: json[kCode],
      unit: json[kUnit],
      price: json[kPrice],
      report: json[kReport],
      choosed: json[kChoosed],
      display: json[kDisplay],
      editQuantity: json[kEditQuantity],
      priceRequired: json[kPriceRequired],
      priceInsurance: json[kPriceInsurance],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: super.code,
      kUnit: super.unit,
      kPrice: super.price,
      kReport: super.report,
      kChoosed: super.choosed,
      kDisplay: super.display,
      kEditQuantity: super.editQuantity,
      kPriceRequired: super.priceRequired,
      kPriceInsurance: super.priceInsurance,
    };
  }
}
