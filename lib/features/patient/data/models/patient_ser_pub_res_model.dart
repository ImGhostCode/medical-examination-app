import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_ser_pub_res_entity.dart';

class PatientSerPubResModel extends PatientSerPubResEntity {
  PatientSerPubResModel({
    super.id,
    // ext,
    // org,
    super.code,
    // reason,
    super.requester,
  });

  factory PatientSerPubResModel.fromJson({required Map<String, dynamic> json}) {
    return PatientSerPubResModel(
      id: json[kId],
      // ext: json['ext'],
      // org: json['org'],
      code: json[kCode],
      // reason: json['reason'],
      requester: json[kRequester],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      // 'ext': ext,
      // 'org': org,
      kCode: code,
      // 'reason': reason,
      kRequester: requester,
    };
  }
}
