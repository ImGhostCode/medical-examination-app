import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/health_insurance_card.dart';

class HealthInsuranceCardModel extends HealthInsuranceCardEntity {
  HealthInsuranceCardModel(
      {required super.seq,
      required super.code,
      required super.rate,
      required super.period,
      required super.delegate,
      required super.expensed,
      required super.pictures,
      required super.cardObject});

  factory HealthInsuranceCardModel.fromJson(
      {required Map<String, dynamic> json}) {
    return HealthInsuranceCardModel(
      seq: json[kSeq],
      code: json[kCode],
      rate: json[kRate],
      period: json[kPeriod],
      delegate: json[kDelegate],
      expensed: json[kExpensed],
      pictures: json[kPictures],
      cardObject: json[kCardObject],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kSeq: seq,
      kCode: code,
      kRate: rate,
      kPeriod: period,
      kDelegate: delegate,
      kExpensed: expensed,
      kPictures: pictures,
      kCardObject: cardObject,
    };
  }
}
