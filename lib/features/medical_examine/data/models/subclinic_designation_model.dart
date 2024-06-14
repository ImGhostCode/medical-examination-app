import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/subclinic_designation_entity.dart';

class SubclinicDesignationModel extends SubclinicDesignationEntity {
  SubclinicDesignationModel(
      {super.id,
      super.ref,
      super.para,
      super.encounter,
      super.fileName,
      super.pageSize,
      super.code});

  factory SubclinicDesignationModel.fromJson(
      {required Map<String, dynamic> json}) {
    return SubclinicDesignationModel(
      id: json[kId],
      ref: json[kRef],
      para: json[kPara] != null
          ? json[kPara]
              .map<ParaModel>((e) => ParaModel.fromJson(json: e))
              .toList()
          : [],
      encounter: json[kEncounter],
      fileName: json[kFileName],
      pageSize: json[kPageSize],
      code: json[kCode],
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
      kCode: code,
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
