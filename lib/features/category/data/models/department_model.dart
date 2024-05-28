import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';

class DepartmentModel extends DepartmentEntity {
  DepartmentModel(
      {required super.code,
      required super.type,
      required super.admin,
      required super.allow,
      required super.value,
      required super.dDefault,
      required super.display,
      required super.typeCode,
      required super.roleGroup,
      required super.typeDisplay});

  factory DepartmentModel.fromJson({required Map<String, dynamic> json}) {
    return DepartmentModel(
      code: json[kCode],
      type: json[kType],
      admin: json[kAdmin],
      allow: json[kAllow],
      value: json[kValue],
      dDefault: json[kDDefault],
      display: json[kDisplay],
      typeCode: json[kTypeCode],
      roleGroup: json[kRoleGroup],
      typeDisplay: json[kTypeDisplay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kType: type,
      kAdmin: admin,
      kAllow: allow,
      kValue: value,
      kDDefault: dDefault,
      kDisplay: display,
      kTypeCode: typeCode,
      kRoleGroup: roleGroup,
      kTypeDisplay: typeDisplay,
    };
  }
}
