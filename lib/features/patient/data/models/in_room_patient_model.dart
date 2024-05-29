import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';

class InRoomPatientModel extends InRoomPatientEntity {
  InRoomPatientModel(
      {required super.code,
      required super.name,
      required super.start,
      required super.gender,
      required super.subject,
      required super.birthdate,
      required super.encounter,
      required super.feeObject,
      super.classifyCode,
      super.classifyName,
      required super.processingStatus});

  factory InRoomPatientModel.fromJson({required Map<String, dynamic> json}) {
    return InRoomPatientModel(
      code: json[kCode],
      name: json[kName],
      start: json[kStart],
      gender: json[kGender] == 'male' ? 'Nam' : 'Nữ',
      subject: json[kSubject],
      birthdate: json[kBirthdate],
      encounter: json[kEncounter],
      feeObject: json[kFeeObject] ?? '',
      classifyCode: json[kClassifyCode] ?? '',
      classifyName: json[kClassifyName] ?? '',
      processingStatus: json[kProcessingStatus],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kCode: super.code,
      kName: super.name,
      kStart: super.start,
      kGender: super.gender,
      kSubject: super.subject,
      kBirthdate: super.birthdate,
      kEncounter: super.encounter,
      kFeeObject: super.feeObject,
      kClassifyCode: super.classifyCode,
      kClassifyName: super.classifyName,
      kProcessingStatus: super.processingStatus,
    };
  }
}
