import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/data/models/in_room_patient_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_ser_pub_res_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_service_model.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class PatientRemoteDataSource {
  Future<ResponseModel<List<InRoomPatientModel>>> getPatientsInRoom(
      {required GetPatientInRoomParams getPatientInRoomParams});
  Future<ResponseModel<PatientModel>> getPatientInfo(
      {required GetPatientInfoParams getPatientInfoParams});
  Future<ResponseModel<List<PatientServiceModel>>> getPatientServices(
      {required GetPatientServiceParams getPatientServiceParams});
  Future<ResponseModel<List<PatientSerPubResModel>>> publishPatientServices(
      {required PublishPatientServiceParams publishPatientServiceParams});
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final Dio dio;

  PatientRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel<List<InRoomPatientModel>>> getPatientsInRoom(
      {required GetPatientInRoomParams getPatientInRoomParams}) async {
    try {
      final response = await dio.get(
          '/patient/list/${paramToBase64(getPatientInRoomParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getPatientInRoomParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<InRoomPatientModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<InRoomPatientModel>(
                  (e) => InRoomPatientModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<PatientModel>> getPatientInfo(
      {required GetPatientInfoParams getPatientInfoParams}) async {
    try {
      final response = await dio.get(
          '/patient/medical/${paramToBase64(getPatientInfoParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getPatientInfoParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<PatientModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => PatientModel.fromJson(json: json));
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<PatientServiceModel>>> getPatientServices(
      {required GetPatientServiceParams getPatientServiceParams}) async {
    try {
      final response = await dio.get(
          '/medical/service/${paramToBase64(getPatientServiceParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getPatientServiceParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<PatientServiceModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<PatientServiceModel>(
                  (e) => PatientServiceModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<PatientSerPubResModel>>> publishPatientServices(
      {required PublishPatientServiceParams
          publishPatientServiceParams}) async {
    try {
      final response = await dio.put('/medical/service/status',
          data: {
            "data": {
              "type": publishPatientServiceParams.type,
              "encounter": publishPatientServiceParams.encounter,
              "doctor": publishPatientServiceParams.doctor,
              "items": publishPatientServiceParams.items
                  .map((e) => {
                        "ref_idx": e.refIdx,
                        "code": e.code,
                        "seq": 0,
                        "ordinal": 0,
                        "encounter": null,
                        "unit": null,
                        "valueString": null,
                        "classify": null
                      })
                  .toList(),
              "note": publishPatientServiceParams.note,
            },
            "token": publishPatientServiceParams.token,
            "ip": "192:168:1:8",
            "code": "ad568891-dbc4-4241-a122-abb127901972"
          },
          options: Options(headers: {
            // "token": publishPatientServiceParams.token,
          }));

      if (response.data.runtimeType == ResponseModel &&
          response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      var temp = response.data;
      response.data = <String, dynamic>{};

      // add Code, Type, Status, Message to response.data
      response.data[kData] = temp;
      response.data[kCode] = response.data[kCode] ?? '';
      response.data[kType] = response.data[kType] ?? '';
      response.data[kStatus] = response.data[kStatus] ?? '';
      response.data[kMessage] = response.data[kMessage] ?? '';
      return ResponseModel<List<PatientSerPubResModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<PatientSerPubResModel>(
                  (e) => PatientSerPubResModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
