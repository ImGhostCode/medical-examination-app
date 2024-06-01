import 'package:medical_examination_app/core/common/helpers.dart';

import '../../../../../core/constants/constants.dart';
import '../../business/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.code,
      required super.work,
      required super.token,
      required super.display,
      required super.expired,
      required super.userName,
      required super.isChangeNow,
      required super.functions,
      required super.organization});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: json[kId],
      code: json[kCode],
      work: workToRole(json[kWork]),
      token: json[kToken],
      display: json[kDisplay],
      expired: json[kExpired],
      userName: json[kUserName],
      isChangeNow: json[kIsChangeNow],
      functions: json[kFunctions]
          .map<FunctionModel>(
              (function) => FunctionModel.fromJson(json: function))
          .toList(),
      organization: OrganizationModel.fromJson(json: json[kOrganization]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kCode: code,
      kWork: work,
      kToken: token,
      kDisplay: display,
      kExpired: expired,
      kUserName: userName,
      kIsChangeNow: isChangeNow,
      kFunctions: (functions as List<FunctionModel>)
          .map((function) => function.toJson())
          .toList(),
      kOrganization: (organization as OrganizationModel).toJson(),
    };
  }
}

class OrganizationModel extends OrganizationEntity {
  const OrganizationModel(
      {required super.code, required super.value, required super.display});

  factory OrganizationModel.fromJson({required Map<String, dynamic> json}) {
    return OrganizationModel(
      code: json[kCode],
      value: json[kValue],
      display: json[kDisplay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kValue: value,
      kDisplay: display,
    };
  }
}

class FunctionModel extends FunctionEntity {
  const FunctionModel(
      {required super.code,
      required super.allow,
      required super.fDefault,
      required super.display});

  factory FunctionModel.fromJson({required Map<String, dynamic> json}) {
    return FunctionModel(
      code: json[kCode],
      allow: json[kAllow],
      fDefault: json[kFDefault],
      display: json[kDisplay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kAllow: allow,
      kFDefault: fDefault,
      kDisplay: display,
    };
  }
}
