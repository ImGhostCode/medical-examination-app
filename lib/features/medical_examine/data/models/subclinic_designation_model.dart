import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/subclinic_designation_entity.dart';

class SubclinicDesignationModel extends SubclinicDesignationEntity {
  SubclinicDesignationModel(
      {required super.id,
      required super.ref,
      required super.para,
      required super.encounter,
      required super.fileName,
      required super.pageSize});

  factory SubclinicDesignationModel.fromJson(
      {required Map<String, dynamic> json}) {
    return SubclinicDesignationModel(
      id: json[kId],
      ref: json[kRef],
      para: json[kPara].map((e) => ParaModel.fromJson(json: e)),
      encounter: json[kEncounter],
      fileName: json[kFileName],
      pageSize: json[kPageSize],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kRef: ref,
      kPara: (para as List<ParaModel>).map((e) => e.toJson()).toList(),
      kEncounter: encounter,
      kFileName: fileName,
      kPageSize: pageSize,
    };
  }
}

class ParaModel extends Para {
  ParaModel({required super.code, required super.value});

  factory ParaModel.fromJson({required Map<String, dynamic> json}) {
    return ParaModel(
      code: json[kCode],
      value: json[kValue],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kValue: value,
    };
  }
}
