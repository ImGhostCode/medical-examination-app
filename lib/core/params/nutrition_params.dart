import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';

class GetNutritionParams {
  String key;
  String token;

  GetNutritionParams({required this.key, required this.token});
}

// {"status":"all","org":"all","from":"2024-03-23 00:00:00","to":"2024-03-23 23:59:59"}
class GetNutritionOrderParams {
  String token;
  String status;
  dynamic org;
  String from;
  String to;

  GetNutritionOrderParams(
      {required this.token,
      required this.status,
      required this.org,
      required this.from,
      required this.to});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'org': org,
      'from': from,
      'to': to,
    };
  }
}

class AssignNutritionParams {
  int doctor;
  int services;
  List<InRoomPatientEntity> patients;
  String isPublish;
  String planDate;
  int quantity;
  String token;
  String ip;
  String code;

  AssignNutritionParams(
      {required this.doctor,
      required this.services,
      required this.patients,
      required this.isPublish,
      required this.planDate,
      required this.quantity,
      required this.token,
      required this.ip,
      required this.code});
}

class ModifyNutritionOrderParams {
  String action;
  List<NutritionOrderEntity> nutritionOrders;
  String token;
  String ip;
  String code;

  ModifyNutritionOrderParams(
      {required this.action,
      required this.nutritionOrders,
      required this.token,
      required this.ip,
      required this.code});
}

// {"division":"29587","date": "2024-03-19","status":"nutrition_order_detail"}
class GetOrderedNutritionParams {
  String division;
  String date;
  String status;
  String token;

  GetOrderedNutritionParams(
      {required this.division,
      required this.date,
      required this.status,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      'division': division,
      'date': date,
      'status': status,
    };
  }
}
