import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';

class SubclinicServiceModel extends SubclinicServiceEntity {
  SubclinicServiceModel(
      {required super.cc,
      required super.dv,
      required super.tt,
      required super.code,
      required super.unit,
      required super.price,
      required super.value,
      required super.report,
      required super.choosed,
      required super.display,
      required super.groupId,
      required super.quantity,
      required super.isPublic,
      required super.obsGroup,
      required super.createUid,
      required super.obsResult,
      required super.editQuantity,
      required super.priceRequired,
      required super.priceInsurance});

  factory SubclinicServiceModel.fromJson({required Map<String, dynamic> json}) {
    return SubclinicServiceModel(
      cc: json[kCc],
      dv: json[kDv],
      tt: json[kTt],
      code: json[kCode],
      unit: json[kUnit],
      price: json[kPrice],
      value: json[kValue],
      report: json[kReport],
      choosed: json[kChoosed],
      display: json[kDisplay],
      groupId: json[kGroupId],
      quantity: json[kQuantity],
      isPublic: json[kIsPublic],
      obsGroup: json[kObsGroup],
      createUid: json[kCreateUid],
      obsResult: json[kObsResult],
      editQuantity: json[kEditQuantity],
      priceRequired: json[kPriceRequired],
      priceInsurance: json[kPriceInsurance],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCc: cc,
      kDv: dv,
      kTt: tt,
      kCode: code,
      kUnit: unit,
      kPrice: price,
      kValue: value,
      kReport: report,
      kChoosed: choosed,
      kDisplay: display,
      kGroupId: groupId,
      kQuantity: quantity,
      kIsPublic: isPublic,
      kObsGroup: obsGroup,
      kCreateUid: createUid,
      kObsResult: obsResult,
      kEditQuantity: editQuantity,
      kPriceRequired: priceRequired,
      kPriceInsurance: priceInsurance,
    };
  }
}
