import 'package:flutter/foundation.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';
import 'package:medical_examination_app/features/patient/data/models/health_insurance_card_model.dart';

class PatientModel extends PatientEntity {
  PatientModel(
      {required super.name,
      required super.birthdate,
      required super.gender,
      required super.ethnic,
      required super.nationality,
      required super.job,
      required super.address,
      required super.open,
      required super.status,
      required super.subject,
      required super.location,
      required super.pictures,
      required super.encounter,
      required super.birthYear,
      required super.dateStart,
      required super.diagnostic,
      required super.genderName,
      required super.organization,
      required super.medicalClass,
      required super.medicalObject,
      required super.treatmentStart,
      required super.templateClassify,
      super.ci,
      super.healthInsuranceCard,
      super.dateEnd,
      super.literacy,
      super.religion,
      super.relativeInfo});

  factory PatientModel.fromJson({required Map<String, dynamic> json}) {
    return PatientModel(
      name: json[kName],
      birthdate: json[kBirthdate],
      gender: json[kGender],
      ethnic: json[kEthnic],
      nationality: json[kNationality],
      job: json[kJob],
      address: json[kAddress],
      open: json[kOpen],
      status: json[kStatus],
      subject: json[kSubject],
      location: json[kLocation]
          .map<LocationModel>((e) => LocationModel.fromJson(json: e))
          .toList(),
      pictures: json[kPictures].map<String>((e) => e.toString()).toList(),
      encounter: json[kEncounter],
      birthYear: json[kBirthYear],
      dateStart: json[kDateStart],
      diagnostic: json[kDiagnostic],
      genderName: json[kGenderName],
      organization: OrganizationModel.fromJson(json: json[kOrganization]),
      medicalClass: json[kMedicalClass],
      medicalObject: json[kMedicalObject],
      treatmentStart: json[kTreatmentStart],
      templateClassify: json[kTemplateClassify],
      ci: json[kCi] != null ? CiModel.fromJson(json: json[kCi]) : null,
      healthInsuranceCard: mapEquals(json[kHealthInsuranceCard], {})
          ? null
          : HealthInsuranceCardModel.fromJson(json: json[kHealthInsuranceCard]),
      dateEnd: json[kDateEnd],
      literacy: json[kLiteracy],
      religion: json[kReligion],
      relativeInfo: json[kRelativeInfo],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kName: name,
      kBirthdate: birthdate,
      kGender: gender,
      kEthnic: ethnic,
      kNationality: nationality,
      kJob: job,
      kAddress: address,
      kOpen: open,
      kStatus: status,
      kSubject: subject,
      kLocation:
          (location as List<LocationModel>).map((e) => e.toJson()).toList(),
      kPictures: pictures,
      kEncounter: encounter,
      kBirthYear: birthYear,
      kDateStart: dateStart,
      kDiagnostic: diagnostic,
      kGenderName: genderName,
      kOrganization: organization,
      kMedicalClass: medicalClass,
      kMedicalObject: medicalObject,
      kTreatmentStart: treatmentStart,
      kTemplateClassify: templateClassify,
      kCi: (ci as CiModel).toJson(),
      kHealthInsuranceCard:
          (healthInsuranceCard as HealthInsuranceCardModel).toJson(),
      kDateEnd: dateEnd,
      kLiteracy: literacy,
      kReligion: religion,
      kRelativeInfo: relativeInfo,
    };
  }
}

class CiModel extends CiEntity {
  CiModel({required super.number, required super.date, required super.issuer});

  factory CiModel.fromJson({required Map<String, dynamic> json}) {
    return CiModel(
      number: json[kNumber],
      date: json[kDate],
      issuer: json[kIssuer],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kNumber: number,
      kDate: date,
      kIssuer: issuer,
    };
  }
}

class LocationModel extends LocationEntity {
  LocationModel(
      {required super.seq,
      required super.code,
      required super.value,
      required super.display,
      required super.feeObject});

  factory LocationModel.fromJson({required Map<String, dynamic> json}) {
    return LocationModel(
      seq: json[kSeq],
      code: json[kCode],
      value: json[kValue],
      display: json[kDisplay],
      feeObject: json[kFeeObject],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kSeq: seq,
      kCode: code,
      kValue: value,
      kDisplay: display,
      kFeeObject: feeObject,
    };
  }
}

class OrganizationModel extends Organization {
  OrganizationModel(
      {required super.code, required super.value, required super.display});

  factory OrganizationModel.fromJson({required Map<String, dynamic> json}) {
    return OrganizationModel(
      code: json[kOrganizationCode],
      value: json[kValue],
      display: json[kDisplay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOrganizationCode: code,
      kValue: value,
      kDisplay: display,
    };
  }
}
