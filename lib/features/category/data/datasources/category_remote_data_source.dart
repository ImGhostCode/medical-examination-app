import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/common/helpers.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/data/models/department_model.dart';
import 'package:medical_examination_app/features/category/data/models/icd_model.dart';
import 'package:medical_examination_app/features/category/data/models/subcli_serv_group_model.dart';
import 'package:medical_examination_app/features/category/data/models/subclinic_service_model.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class CategoryRemoteDataSource {
  Future<ResponseModel<List<DepartmentModel>>> getDepartments(
      {required GetDepartmentPrarams getDepartmentPrarams});
  Future<ResponseModel<List<ICDModel>>> getICD(
      {required GetICDPrarams getICDPrarams});
  Future<ResponseModel<List<SubcliServGroupModel>>> getSubclinicServiceGroups(
      {required GetSubclinicServiceGroupPrarams
          getSubclinicServiceGroupPrarams});
  Future<ResponseModel<List<SubclinicServiceModel>>> getSubclinicServices(
      {required GetSubclinicServicePrarams getSubclinicServicePrarams});
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel<List<DepartmentModel>>> getDepartments(
      {required GetDepartmentPrarams getDepartmentPrarams}) async {
    try {
      final response = await dio.get(
          '/location/list/${paramToBase64(getDepartmentPrarams.toMap())}',
          queryParameters: {},
          options: Options(headers: {"token": getDepartmentPrarams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<DepartmentModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<DepartmentModel>((e) => DepartmentModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<SubclinicServiceModel>>> getSubclinicServices(
      {required GetSubclinicServicePrarams getSubclinicServicePrarams}) async {
    try {
      final response = await dio.get(
          '/services/${paramToBase64(getSubclinicServicePrarams.key)}',
          queryParameters: {},
          options:
              Options(headers: {"token": getSubclinicServicePrarams.token}));

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
  Future<ResponseModel<List<SubcliServGroupModel>>> getSubclinicServiceGroups(
      {required GetSubclinicServiceGroupPrarams
          getSubclinicServiceGroupPrarams}) async {
    try {
      final response = await dio.get(
          '/services/${paramToBase64(getSubclinicServiceGroupPrarams.type)}',
          queryParameters: {},
          options: Options(
              headers: {"token": getSubclinicServiceGroupPrarams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<SubcliServGroupModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) => json
              .map<SubcliServGroupModel>(
                  (e) => SubcliServGroupModel.fromJson(json: e))
              .toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }

  @override
  Future<ResponseModel<List<ICDModel>>> getICD(
      {required GetICDPrarams getICDPrarams}) async {
    try {
      final response = await dio.get(
          '/system/list/${paramToBase64(getICDPrarams.key)}',
          queryParameters: {},
          options: Options(headers: {"token": getICDPrarams.token}));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<List<ICDModel>>.fromJson(
          json: response.data,
          fromJsonD: (json) =>
              json.map<ICDModel>((e) => ICDModel.fromJson(json: e)).toList());
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
