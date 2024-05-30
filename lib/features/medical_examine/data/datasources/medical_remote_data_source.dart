import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/care_sheet_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/signal_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/streatment_sheet_model.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class MedicalExamineRemoteDataSource {
  Future<ResponseModel<List<SignalModel>>> loadSignals(
      {required LoadSignalParams loadSignalParams});
  Future<ResponseModel<List<SignalModel>>> getEnteredSignals(
      {required GetEnteredSignalParams getEnteredSignalParams});
  Future<ResponseModel<List<StreatmentSheetModel>>> getEnteredStreatmentSheets(
      {required GetEnteredStreamentSheetParams getEnteredStreamentSheetParams});
  Future<ResponseModel<List<CareSheetModel>>> getEnteredCareSheets(
      {required GetEnteredCareSheetParams getEnteredCareSheetParams});
}

class MedicalExamineRemoteDataSourceImpl
    implements MedicalExamineRemoteDataSource {
  final Dio dio;

  MedicalExamineRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel<List<SignalModel>>> loadSignals(
      {required LoadSignalParams loadSignalParams}) async {
    try {
      final response = await dio.get(
          '/dashboard/medical/signals/${paramToBase64(loadSignalParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": loadSignalParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<SignalModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<SignalModel>((e) => SignalModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<SignalModel>>> getEnteredSignals(
      {required GetEnteredSignalParams getEnteredSignalParams}) async {
    try {
      final response = await dio.get(
          '/observation/signal/${paramToBase64(getEnteredSignalParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getEnteredSignalParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<SignalModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<SignalModel>((e) => SignalModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<StreatmentSheetModel>>> getEnteredStreatmentSheets(
      {required GetEnteredStreamentSheetParams
          getEnteredStreamentSheetParams}) async {
    try {
      final response = await dio.get(
          '/medical/visit/${paramToBase64(getEnteredStreamentSheetParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getEnteredStreamentSheetParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<StreatmentSheetModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<StreatmentSheetModel>(
                  (e) => StreatmentSheetModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<CareSheetModel>>> getEnteredCareSheets(
      {required GetEnteredCareSheetParams getEnteredCareSheetParams}) async {
    try {
      final response = await dio.get(
          '/medical/visit/${paramToBase64(getEnteredCareSheetParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getEnteredCareSheetParams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<CareSheetModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<CareSheetModel>((e) => CareSheetModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
