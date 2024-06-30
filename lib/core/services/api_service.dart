import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Singleton Pattern
class ApiService {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  ApiService._internal();

  static init() {
    _dio.options.baseUrl = dotenv.env['BASE_URL']!;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.connectTimeout =
        const Duration(milliseconds: 500); // Timeout sau 5 giây
    _dio.options.receiveTimeout =
        const Duration(milliseconds: 30000); // Timeout nhận dữ liệu sau 3 giây
  }
}
