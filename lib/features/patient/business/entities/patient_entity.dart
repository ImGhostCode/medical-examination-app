import 'package:medical_examination_app/features/patient/business/entities/health_insurance_card.dart';

class PatientEntity {
  CiEntity? ci;
  String job;
  HealthInsuranceCardEntity? healthInsuranceCard;
  String name;
  bool open;
  String? start;
  String ethnic;
  String gender;
  String status;
  String address;
  int subject;
  String? dateEnd;
  String? literacy;
  List<LocationEntity> location;
  List<String> pictures;
  String? religion;
  String birthdate;
  int encounter;
  String birthYear;
  String dateStart;
  String diagnostic;
  String genderName;
  String nationality;
  Organization organization;
  String medicalClass;
  String? relativeInfo;
  String medicalObject;
  String treatmentStart;
  String templateClassify;

  // MedicalEntity medical;
  // List<TelecomEntity> telecom;
  // List<ContactEnitity> contact;
  // ServicesEntity services;
  // String lrCode;
  // QueueZoneReceptionEntity queueZoneReception;
  // bool overwrite;

  PatientEntity({
    required this.name,
    required this.birthdate,
    required this.gender,
    this.healthInsuranceCard,
    required this.ethnic,
    required this.nationality,
    this.ci,
    required this.job,
    required this.address,
    required this.open,
    this.start,
    required this.status,
    required this.subject,
    this.dateEnd,
    this.literacy,
    required this.location,
    required this.pictures,
    this.religion,
    required this.encounter,
    required this.birthYear,
    required this.dateStart,
    required this.diagnostic,
    required this.genderName,
    required this.organization,
    required this.medicalClass,
    this.relativeInfo,
    required this.medicalObject,
    required this.treatmentStart,
    required this.templateClassify,
  });
}

class Organization {
  String code;
  int value;
  String display;

  Organization(
      {required this.code, required this.value, required this.display});
}

class LocationEntity {
  int? seq;
  String? code;
  int? value;
  String? display;
  String? feeObject;

  LocationEntity({
    this.seq,
    this.code,
    this.value,
    this.display,
    this.feeObject,
  });
}

class MedicalEntity {
  bool create;
  String type;

  MedicalEntity({required this.create, required this.type});

  // Add fromJson and toJson methods here
}

class CiEntity {
  String number;
  String date;
  String issuer;

  CiEntity({required this.number, required this.date, required this.issuer});

  // Add fromJson and toJson methods here
}

class TelecomEntity {
  String type;
  String value;

  TelecomEntity({required this.type, required this.value});

  // Add fromJson and toJson methods here
}

class ContactEnitity {
  String name;
  String relation;

  ContactEnitity({required this.name, required this.relation});

  // Add fromJson and toJson methods here
}

class AddressEntity {
  String uses;
  String home;
  String ward;

  AddressEntity({required this.uses, required this.home, required this.ward});

  // Add fromJson and toJson methods here
}

class ServicesEntity {
  int doctor;
  String type;
  String isCard;
  List<dynamic> option;
  String request;
  bool emergency;

  ServicesEntity({
    required this.doctor,
    required this.type,
    required this.isCard,
    required this.option,
    required this.request,
    required this.emergency,
  });

  // Add fromJson and toJson methods here
}

class QueueZoneReceptionEntity {
  String zone;
  String table;

  QueueZoneReceptionEntity({required this.zone, required this.table});

  // Add fromJson and toJson methods here
}

/*
{
    "data": {
        "name": "{{$randomFullName}}",
        "birthdate": "1979",
        "gender": "male",
        "medical": {
            "create": true,
            "type": "MRC.AMB"
        },
        "card": {
            "publisher": "BHXH",
            "code": "LP4989101001165",
            "start": "2023-01-01",
            "end": "2025-01-01",
            "delegate": "01001",
            "address": "dc thẻ",
            "living": "K2",
            "longtime": "",
            "time_free": "",
            "unline": false
        },
        "ethnic": "1796",
        "nationality": "VNM",
        "ci": {
            "number": "",
            "date": "",
            "issuer": ""
        },
        "job": "481",
        "telecom": [
            {
                "type": "tax",
                "value": ""
            },
            {
                "type": "sms",
                "value": ""
            },
            {
                "type": "phone",
                "value": ""
            }
        ],
        "contact": [
            {
                "name": "",
                "relation": "S"
            },
            {
                "name": "",
                "relation": "N"
            }
        ],
        "address": {
            "uses": "home",
            "home": "",
            "ward": "826"
        },
        "services": {
            "doctor": 16631,
            "type": "fee",
            "is_card": "off",
            "option": [],
            "request": "29664",
            "emergency": false
        },
        "lr_code": "",
        "queue_zone_reception": {
            "zone": "",
            "table": ""
        },
        "overwrite": false
    },
    "token": "{{token}}",
    "ip": "192:168:1:11",
    "code": "ad568891-dbc4-4241-a122-abb127901972"
}
*/