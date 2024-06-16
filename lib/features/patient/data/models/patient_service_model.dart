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
      super.result});

  factory PatientServiceModel.fromJson({required Map<String, dynamic> json}) {
    return PatientServiceModel(
      id: json[kId],
      type: json[kType],
      owner: json[kOwner],
      price: json[kPrice].toInt(),
      status: json[kStatus],
      creators: json[kCreators],
      service: json[kService],
      reportCode: json[kReportCode],
      quantity: json[kQuantity].toInt(),
      unit: json[kUnit],
      result: json[kResult],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: super.id,
      kType: super.type,
      kOwner: super.owner,
      kPrice: super.price,
      kStatus: super.status,
      kCreators: super.creators,
      kService: super.service,
      kReportCode: super.reportCode,
      kQuantity: super.quantity,
      kUnit: super.unit,
      kResult: super.result,
    };
  }
}
