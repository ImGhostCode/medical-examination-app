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
      period: PeriodModel.fromJson(json: json[kPeriod]),
      delegate: json[kDelegate],
      expensed: ExpensedModel.fromJson(json: json[kExpensed]),
      pictures: json[kPictures],
      cardObject: json[kCardObject],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kSeq: seq,
      kCode: code,
      kRate: rate,
      kPeriod: (period as PeriodModel).toJson(),
      kDelegate: delegate,
      kExpensed: (expensed as ExpensedModel).toJson(),
      kPictures: pictures,
      kCardObject: cardObject,
    };
  }
}

class ExpensedModel extends ExpensedEntity {
  ExpensedModel(
      {required super.crdAd, required super.crdCt, required super.crdLa});

  factory ExpensedModel.fromJson({required Map<String, dynamic> json}) {
    return ExpensedModel(
      crdAd: json[kCrdAd],
      crdCt: json[kCrdCt],
      crdLa: json[kCrdLa],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCrdAd: crdAd,
      kCrdCt: crdCt,
      kCrdLa: crdLa,
    };
  }
}

class PeriodModel extends PeriodEntity {
  PeriodModel({required super.start, required super.end});

  factory PeriodModel.fromJson({required Map<String, dynamic> json}) {
    return PeriodModel(
      start: json[kStart],
      end: json[kEnd],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kStart: start,
      kEnd: end,
    };
  }
}
