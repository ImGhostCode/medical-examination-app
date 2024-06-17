import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';

class SubclinicServiceModel extends SubclinicServiceEntity {
  SubclinicServiceModel(
      {super.refIdx,
      super.cc,
      super.dv,
      super.tt,
      super.code,
      super.unit,
      super.price,
      super.value,
      super.report,
      super.choosed,
      super.display,
      super.groupId,
      super.quantity,
      super.isPublic,
      super.obsGroup,
      super.createUid,
      super.obsResult,
      super.editQuantity,
      super.priceRequired,
      super.priceInsurance,
      super.result,
      super.creators,
      super.id,
      super.location});

  factory SubclinicServiceModel.fromJson({required Map<String, dynamic> json}) {
    return SubclinicServiceModel(
      refIdx: json[kRefIdx],
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
      result: json[kResult],
      creators: json[kCreators],
      id: json[kId],
      location: json[kLocation],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kRefIdx: refIdx,
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
      kResult: result,
      kCreators: creators,
      kId: id,
      kLocation: location,
    };
  }
}
