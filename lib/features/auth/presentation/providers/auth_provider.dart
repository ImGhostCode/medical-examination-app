import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/features/auth/business/usecases/login_usecase.dart';
import 'package:medical_examination_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medical_examination_app/features/auth/data/datasources/template_local_data_source.dart';
import 'package:medical_examination_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../user/business/entities/user_entity.dart';

final FlutterSecureStorage secureStorage = SecureStorageService.secureStorage;

class AuthProvider extends ChangeNotifier {
  String code;
  String type;
  String status;
  String message;
  UserEntity? userEntity;
  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthProvider({
    this.userEntity,
    this.failure,
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
  });

  Future eitherFailureOrLogin(
      String rdKey, String user, String password) async {
    isLoading = true;
    AuthRepositoryImpl repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: AuthLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrAuth = await LoginUsecase(authRepository: repository).call(
      loginParams: LoginParams(rdKey: rdKey, user: user, password: password),
    );

    failureOrAuth.fold(
      (Failure newFailure) {
        isLoading = false;
        userEntity = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<UserEntity> response) {
        isLoading = false;
        userEntity = response.data;
        secureStorage.write(key: 'token', value: userEntity!.token);
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }
}
