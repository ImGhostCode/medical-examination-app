import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/template_model.dart';

abstract class TemplateRemoteDataSource {
  Future<TemplateModel> getTemplate({required TemplateParams templateParams});
}

class TemplateRemoteDataSourceImpl implements TemplateRemoteDataSource {
  final Dio dio;

  TemplateRemoteDataSourceImpl({required this.dio});

  @override
  Future<TemplateModel> getTemplate(
      {required TemplateParams templateParams}) async {
    try {
      final response = await dio.get('/',
          queryParameters: {},
          options: Options(headers: {
            // "authorization": "Bearer ${getUserParams.accessToken}"
          }));

      return TemplateModel.fromJson(json: response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: 'Unknown Erorr',
          code: e.response!.statusCode!.toString(),
          status: 'error');
    }
  }
}
