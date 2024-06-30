import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';

class PatientServiceModel extends PatientServiceEntity {
  PatientServiceModel(
      {required super.id,
      required super.type,
      super.owner,
      required super.price,
      required super.status,
      super.creators,
      required super.service,
      required super.reportCode,
      required super.quantity,
      required super.unit,
      super.refIdx,
      required super.seq,
      super.result});

  factory PatientServiceModel.fromJson({required Map<String, dynamic> json}) {
    return PatientServiceModel(
      id: json[kId],
      type: json[kType],
      owner: json[kOwner],
      price: json[kAmount] != null ? json[kAmount].toInt() : 0,
      status: json[kStatus],
      creators: json[kCreators],
      service: json[kService],
      reportCode: json[kReportCode],
      quantity: json[kQuantity].toInt(),
      unit: json[kUnit],
      result: json[kResult],
      refIdx: json[kRefIdx],
      seq: json[kSeq],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kType: type,
      kOwner: owner,
      kPrice: price,
      kStatus: status,
      kCreators: creators,
      kService: service,
      kReportCode: reportCode,
      kQuantity: quantity,
      kUnit: unit,
      kResult: result,
      kRefIdx: refIdx,
      kSeq: seq,
    };
  }
}
