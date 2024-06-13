import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/category/business/entities/icd_entity.dart';

class ICDModel extends ICDEntity {
  ICDModel(
      {required super.code,
      required super.reason,
      required super.display,
      required super.accident,
      required super.isLeftRight});

  factory ICDModel.fromJson({required Map<String, dynamic> json}) {
    return ICDModel(
      code: json[kCode],
      reason: json[kReason],
      display: json[kDisplay],
      accident: json[kAccident],
      isLeftRight: json[kIsLeftRight],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: code,
      kReason: reason,
      kDisplay: display,
      kAccident: accident,
      kIsLeftRight: isLeftRight,
    };
  }
}
