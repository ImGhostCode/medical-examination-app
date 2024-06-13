import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/sublin_serv_group_entity.dart';

class SubcliServGroupModel extends SublicServGroupEntity {
  SubcliServGroupModel({required super.code, required super.display});

  factory SubcliServGroupModel.fromJson({required Map<String, dynamic> json}) {
    return SubcliServGroupModel(
      code: json[kCode],
      display: json[kDisplay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: super.code,
      kDisplay: super.display,
    };
  }
}
