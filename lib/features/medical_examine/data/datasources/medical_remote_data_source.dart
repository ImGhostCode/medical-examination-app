import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/enums.dart';
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
  Future<ResponseModel<String>> modifySignal(
      {required ModifySignalParams modifySignalParams});
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

  @override
  Future<ResponseModel<String>> modifySignal(
      {required ModifySignalParams modifySignalParams}) async {
    try {
      final response = await dio.put('/observation/signal',
          queryParameters: {},
          data: {
            if (modifySignalParams.data.status == SignalStatus.NEW)
              "data": {
                "type": modifySignalParams.data.status,
                "code": modifySignalParams.data.code,
                "value": modifySignalParams.data.value,
                "value_string": modifySignalParams.data.valueString,
                "unit": modifySignalParams.data.unit,
                "encounter": modifySignalParams.encounter,
                "request": modifySignalParams.request,
                "division": modifySignalParams.division,
              },
            if (modifySignalParams.data.status == SignalStatus.EDIT)
              "data": {
                "type": modifySignalParams.data.status,
                "code": modifySignalParams.data.code,
                "seq": modifySignalParams.data.seq,
                "value": modifySignalParams.data.value,
                "value_string": modifySignalParams.data.valueString,
                "unit": modifySignalParams.data.unit,
                "encounter": modifySignalParams.encounter,
              },
            if (modifySignalParams.data.status == SignalStatus.CANCEL)
              "data": {
                "type": modifySignalParams.data.status,
                "code": modifySignalParams.data.id,
                "seq": modifySignalParams.data.seq,
                "encounter": modifySignalParams.encounter,
                "note": modifySignalParams.data.note,
              },
            "token": modifySignalParams.token,
            "ip": "192:168:1:18",
            "code": "ad568891-dbc4-4241-a122-abb127901972"
          },
          options: Options(headers: {}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<String>.fromJson(
          json: response.data, fromJsonD: (json) => json);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
