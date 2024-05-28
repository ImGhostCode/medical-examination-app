import 'package:medical_examination_app/features/patient/business/entities/health_insurance_card.dart';

class PatientInfoEntity {
  String name;
  String birthdate;
  String gender;
  MedicalEntity medical;
  HealthInsuranceCardEntity? healthInsuranceCard;
  String ethnic;
  String nationality;
  CiEntity ci;
  String job;
  List<TelecomEntity> telecom;
  List<ContactEnitity> contact;
  AddressEntity address;
  ServicesEntity services;
  String lrCode;
  QueueZoneReceptionEntity queueZoneReception;
  bool overwrite;

  PatientInfoEntity({
    required this.name,
    required this.birthdate,
    required this.gender,
    required this.medical,
    this.healthInsuranceCard,
    required this.ethnic,
    required this.nationality,
    required this.ci,
    required this.job,
    required this.telecom,
    required this.contact,
    required this.address,
    required this.services,
    required this.lrCode,
    required this.queueZoneReception,
    required this.overwrite,
  });

  // Add fromJson and toJson methods here

  static List<PatientInfoEntity> fakePatients = [
    PatientInfoEntity(
        name: 'Nguyễn Văn A',
        birthdate: '1979',
        gender: 'male',
        medical: MedicalEntity(create: true, type: 'MRC.AMB'),
        ethnic: '1796',
        nationality: 'VNM',
        ci: CiEntity(date: '', issuer: '', number: ''),
        job: '481',
        telecom: [
          TelecomEntity(type: 'tax', value: ''),
          TelecomEntity(type: 'sms', value: ''),
          TelecomEntity(type: 'phone', value: ''),
        ],
        contact: [
          ContactEnitity(name: 'Nguyen Van C', relation: 'S'),
          ContactEnitity(name: 'Nguyen Van B', relation: 'N')
        ],
        address: AddressEntity(home: '', uses: 'home', ward: '826'),
        services: ServicesEntity(
            doctor: 16631,
            type: 'fee',
            isCard: 'off',
            option: [],
            request: '29664',
            emergency: false),
        lrCode: '',
        queueZoneReception: QueueZoneReceptionEntity(zone: '', table: ''),
        overwrite: true),
    PatientInfoEntity(
        name: 'Nguyễn Văn A',
        birthdate: '1979',
        gender: 'male',
        medical: MedicalEntity(create: true, type: 'MRC.AMB'),
        ethnic: '1796',
        nationality: 'VNM',
        ci: CiEntity(date: '', issuer: '', number: ''),
        job: '481',
        telecom: [
          TelecomEntity(type: 'tax', value: ''),
          TelecomEntity(type: 'sms', value: ''),
          TelecomEntity(type: 'phone', value: ''),
        ],
        contact: [
          ContactEnitity(name: 'Nguyen Van C', relation: 'S'),
          ContactEnitity(name: 'Nguyen Van B', relation: 'N')
        ],
        address: AddressEntity(home: '', uses: 'home', ward: '826'),
        services: ServicesEntity(
            doctor: 16631,
            type: 'fee',
            isCard: 'off',
            option: [],
            request: '29664',
            emergency: false),
        lrCode: '',
        queueZoneReception: QueueZoneReceptionEntity(zone: '', table: ''),
        overwrite: true)
  ];
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