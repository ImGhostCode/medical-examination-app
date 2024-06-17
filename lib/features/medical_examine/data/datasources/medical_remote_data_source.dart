import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/enums.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/category/data/models/subclinic_service_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/care_sheet_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/signal_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/streatment_sheet_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/subclinic_designation_model.dart';
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
  Future<ResponseModel<String>> creStreatmentSheet(
      {required CreateStreatmentSheetParams createStreatmentSheetParams});
  Future<ResponseModel<String?>> editStreatmentSheet(
      {required EditStreatmentSheetParams editStreatmentSheetParams});

  Future<ResponseModel<List<CareSheetModel>>> getEnteredCareSheets(
      {required GetEnteredCareSheetParams getEnteredCareSheetParams});
  Future<ResponseModel<String>> creCareSheet(
      {required CreateCareSheetParams createCareSheetParams});
  Future<ResponseModel<String?>> editCareSheet(
      {required EditCareSheetParams editCareSheetParams});

  Future<ResponseModel<String?>> publishMedicalSheet(
      {required PublishMedicalSheetParams publishMedicalSheetParams});

  Future<ResponseModel<List<SubclinicServiceModel>>> getEnteredSubclinicService(
      {required GetEnteredSubclinicServicePrarams
          getEnteredSubclinicServicePrarams});
  Future<ResponseModel<List<SubclinicDesignationModel>>> designSubclinicService(
      {required SubclinicServDesignationParams subclinicServDesignationParams});
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
                "code": modifySignalParams.data.code,
                "seq": modifySignalParams.data.seq,
                "encounter": modifySignalParams.encounter.toString(),
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

  @override
  Future<ResponseModel<String>> creStreatmentSheet(
      {required CreateStreatmentSheetParams
          createStreatmentSheetParams}) async {
    try {
      final response = await dio.post('/medical/visit',
          queryParameters: {},
          data: {
            "data": {
              "type": OET.OET_001.name,
              "encounter": createStreatmentSheetParams.data.encounter,
              "subject": createStreatmentSheetParams.data.subject,
              "division": createStreatmentSheetParams.division,
              "doctor": createStreatmentSheetParams.data.doctor,
              "items": createStreatmentSheetParams.data.value!.map((e) {
                return {
                  "code": e.code,
                  "value": e.value,
                };
              }).toList(),
            },
            "token": createStreatmentSheetParams.token,
            "ip": createStreatmentSheetParams.ip,
            "code": createStreatmentSheetParams.code
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

  @override
  Future<ResponseModel<String>> creCareSheet(
      {required CreateCareSheetParams createCareSheetParams}) async {
    try {
      final response = await dio.post('/medical/visit',
          queryParameters: {},
          data: {
            "data": {
              "type": createCareSheetParams.data.type,
              "encounter": createCareSheetParams.data.encounter,
              "subject": createCareSheetParams.data.subject,
              "division": createCareSheetParams.division,
              "doctor": createCareSheetParams.data.doctor,
              "items": createCareSheetParams.data.value!.map((e) {
                return {
                  "code": e.code,
                  "value": e.value,
                };
              }).toList(),
            },
            "token": createCareSheetParams.token,
            "ip": createCareSheetParams.ip,
            "code": createCareSheetParams.code
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

  @override
  Future<ResponseModel<String?>> editStreatmentSheet(
      {required EditStreatmentSheetParams editStreatmentSheetParams}) async {
    try {
      final response = await dio.put('/medical/visit',
          queryParameters: {},
          data: {
            "data": {
              "id": editStreatmentSheetParams.data.id,
              "encounter": editStreatmentSheetParams.data.encounter,
              "subject": editStreatmentSheetParams.data.subject,
              "type": editStreatmentSheetParams.data.type,
              "request": editStreatmentSheetParams.request,
              "doctor": editStreatmentSheetParams.data.doctor,
              "items": editStreatmentSheetParams.data.value!.map((e) {
                return {
                  "code": e.code,
                  "value": e.value,
                };
              }).toList(),
            },
            "token": editStreatmentSheetParams.token,
            "ip": editStreatmentSheetParams.ip,
            "code": editStreatmentSheetParams.code
          },
          options: Options(headers: {}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<String?>.fromJson(
          json: response.data, fromJsonD: (json) => json);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<String?>> editCareSheet(
      {required EditCareSheetParams editCareSheetParams}) async {
    try {
      final response = await dio.put('/medical/visit',
          queryParameters: {},
          data: {
            "data": {
              "id": editCareSheetParams.data.id,
              "encounter": editCareSheetParams.data.encounter,
              "subject": editCareSheetParams.data.subject,
              "type": editCareSheetParams.data.type,
              "request": editCareSheetParams.request,
              "doctor": editCareSheetParams.data.doctor,
              "items": editCareSheetParams.data.value!.map((e) {
                return {
                  "code": e.code,
                  "value": e.value,
                };
              }).toList(),
            },
            "token": editCareSheetParams.token,
            "ip": editCareSheetParams.ip,
            "code": editCareSheetParams.code
          },
          options: Options(headers: {}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<String?>.fromJson(
          json: response.data, fromJsonD: (json) => json);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<String?>> publishMedicalSheet(
      {required PublishMedicalSheetParams publishMedicalSheetParams}) async {
    try {
      final response = await dio.put('/medical/visit/status',
          queryParameters: {},
          data: {
            "data": {
              "encounter": publishMedicalSheetParams.encounter,
              "id": publishMedicalSheetParams.id,
              "type": publishMedicalSheetParams.type,
              "doctor": publishMedicalSheetParams.doctor,
            },
            "token": publishMedicalSheetParams.token,
            "ip": publishMedicalSheetParams.ip,
            "code": publishMedicalSheetParams.code
          },
          options: Options(headers: {}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<String?>.fromJson(
          json: response.data, fromJsonD: (json) => json);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<SubclinicServiceModel>>> getEnteredSubclinicService(
      {required GetEnteredSubclinicServicePrarams
          getEnteredSubclinicServicePrarams}) async {
    try {
      final response = await dio.get(
          '/medical/service/${paramToBase64(getEnteredSubclinicServicePrarams.toMap())}',
          queryParameters: {},
          options: Options(headers: {
            "token": getEnteredSubclinicServicePrarams.token,
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<SubclinicServiceModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<SubclinicServiceModel>(
                  (e) => SubclinicServiceModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<SubclinicDesignationModel>>> designSubclinicService(
      {required SubclinicServDesignationParams
          subclinicServDesignationParams}) async {
    try {
      final response = await dio.put('/medical/service',
          queryParameters: {},
          data: {
            "data": {
              "status": subclinicServDesignationParams.status,
              "doctor": subclinicServDesignationParams.doctor,
              "services": subclinicServDesignationParams.services.map((e) {
                return {
                  "code": e.code,
                  "quantity": e.quantity,
                  "type": e.type,
                  "is_card": e.isCard,
                  "emergency": e.emergency,
                  "option": e.option,
                  "start": e.start,
                };
              }).toList(),
              "encounter": subclinicServDesignationParams.encounter,
              "subject": subclinicServDesignationParams.subject,
              "reason": {
                "reason": {
                  "text": subclinicServDesignationParams.reason.reason.text,
                  "value": subclinicServDesignationParams.reason.reason.value,
                },
                "new_icds":
                    subclinicServDesignationParams.reason.newIcds.map((e) {
                  return {
                    "code": e.code,
                    "value": e.type,
                  };
                }).toList(),
              },
              if (subclinicServDesignationParams.requrest != null)
                'request': subclinicServDesignationParams.requrest,
              if (subclinicServDesignationParams.requrest == null)
                'division': subclinicServDesignationParams.division,
              "note": subclinicServDesignationParams.note,
              "rate": subclinicServDesignationParams.rate,
              "is_publish": subclinicServDesignationParams.isPublish,
            },
            "token": subclinicServDesignationParams.token,
            "ip": subclinicServDesignationParams.ip,
            "code": subclinicServDesignationParams.code
          },
          options: Options(headers: {}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<SubclinicDesignationModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) {
            if (subclinicServDesignationParams.isPublish) {
              return json
                  .map<SubclinicDesignationModel>(
                      (e) => SubclinicDesignationModel.fromJson(json: e))
                  .toList();
            } else {
              return json['items']
                  .map<SubclinicDesignationModel>(
                      (e) => SubclinicDesignationModel.fromJson(json: e))
                  .toList();
            }
          });
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
