import 'package:dio/dio.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../../../user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseModel<UserModel>> login({required LoginParams loginParams});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel<UserModel>> login(
      {required LoginParams loginParams}) async {
    try {
      final response = await dio.get('/user/login',
          queryParameters: {},
          options: Options(headers: {
            "user": loginParams.user,
            "password": loginParams.password,
            "rd_key": loginParams.rdKey
          }));

      if (response.data[kStatus] == 'error') {
        throw ServerException(
            message: response.data[kMessage],
            code: response.data[kCode],
            status: response.data[kStatus]);
      }

      return ResponseModel<UserModel>.fromJson(
          json: response.data,
          fromJsonD: (json) => UserModel.fromJson(json: json));
    } on DioException catch (e) {
      throw ServerException(
          message: e.response!.data[kMessage],
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
