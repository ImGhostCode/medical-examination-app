import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/data/models/in_room_patient_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_model.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class PatientRemoteDataSource {
  Future<ResponseModel<List<InRoomPatientModel>>> getPatientsInRoom(
      {required GetPatientInRoomParams getPatientInRoomParams});
  Future<ResponseModel<PatientModel>> getPatientInfo(
      {required GetPatientInfoParams getPatientInfoParams});
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
}
