import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/features/nutrition/data/models/nutrition_model.dart';
import 'package:medical_examination_app/features/nutrition/data/models/nutrition_order_model.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class NutritionRemoteDataSource {
  Future<ResponseModel<List<NutritionModel>>> getNutritions(
      {required GetNutritionParams getNutritionParams});
  Future<ResponseModel<List<NutritionOrderModel>>> getNutritionOrders(
      {required GetNutritionOrderParams getNutritionOrderParams});
  Future<ResponseModel<Null>> assignNutrition(
      {required AssignNutritionParams assignNutritionParams});
  Future<ResponseModel<Null>> modifyNutritionOrder(
      {required ModifyNutritionOrderParams modifyNutritionOrderParams});
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  final Dio dio;

  NutritionRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel<List<NutritionModel>>> getNutritions(
      {required GetNutritionParams getNutritionParams}) async {
    try {
      final response = await dio.get(
          '/services/${paramToBase64(getNutritionParams.key)}',
          queryParameters: {},
          options: Options(headers: {"token": getNutritionParams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<NutritionModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<NutritionModel>((e) => NutritionModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<NutritionOrderModel>>> getNutritionOrders(
      {required GetNutritionOrderParams getNutritionOrderParams}) async {
    try {
      final response = await dio.get(
          '/nutrition/order/${paramToBase64(getNutritionOrderParams.toMap())}',
          queryParameters: {},
          options: Options(headers: {"token": getNutritionOrderParams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<NutritionOrderModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<NutritionOrderModel>(
                  (e) => NutritionOrderModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<Null>> assignNutrition(
      {required AssignNutritionParams assignNutritionParams}) async {
    try {
      final response = await dio.post('/nutrition/order',
          queryParameters: {},
          data: {
            "data": {
              "doctor": assignNutritionParams.doctor,
              "services": assignNutritionParams.services,
              "patients": assignNutritionParams.patients
                  .map((e) => {"encounter": e.encounter, "subject": e.subject})
                  .toList(),
              "is_publish": assignNutritionParams.isPublish,
              "planDate": assignNutritionParams.planDate,
              "quantity": assignNutritionParams.quantity
            },
            "token": assignNutritionParams.token,
            "ip": assignNutritionParams.ip,
            "code": assignNutritionParams.code
          },
          options: Options(headers: {"token": assignNutritionParams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<Null>.fromJson(
          json: response.data, fromJsonD: (json) => null);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<Null>> modifyNutritionOrder(
      {required ModifyNutritionOrderParams modifyNutritionOrderParams}) async {
    try {
      final response = await dio.put(
          '/nutrition/${modifyNutritionOrderParams.action}',
          queryParameters: {},
          data: {
            "data": {
              "items": modifyNutritionOrderParams.nutritionOrders
                  .map((e) => {
                        "id": e.id.toString(),
                      })
                  .toList()
            },
            "token": modifyNutritionOrderParams.token,
            "ip": modifyNutritionOrderParams.ip,
            "code": modifyNutritionOrderParams.code
          },
          options:
              Options(headers: {"token": modifyNutritionOrderParams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            hints: response.data[kHints],
            status: response.data[kStatus]);
      }

      return ResponseModel<Null>.fromJson(
          json: response.data, fromJsonD: (json) => null);
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          hints: e.response!.data[kHints],
          status: 'error');
    }
  }
}
