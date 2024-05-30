import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';
import 'package:medical_examination_app/features/category/business/usecases/get_department_usecase.dart';
import 'package:medical_examination_app/features/category/business/usecases/get_subclinic_service_usecase.dart';
import 'package:medical_examination_app/features/category/data/datasources/category_remote_data_source.dart';
import 'package:medical_examination_app/features/category/data/datasources/template_local_data_source.dart';
import 'package:medical_examination_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

final FlutterSecureStorage secureStorage = SecureStorageService.secureStorage;

class CategoryProvider extends ChangeNotifier {
  String code;
  String type;
  String status;
  String message;

  List<DepartmentEntity> listDepartment = [];
  List<SubclinicServiceEntity> listSubclinicServices = [];
  DepartmentEntity? selectedDepartment;
  Failure? failure;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  CategoryProvider({
    this.listDepartment = const [],
    this.failure,
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
  });

  void eitherFailureOrGetDepartments(String type, String kind) async {
    listDepartment = [];
    _isLoading = true;
    CategoryRepositoryImpl repository = CategoryRepositoryImpl(
      remoteDataSource: CategoryRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: CategoryLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrCategory =
        await GetDepartmentUsecase(categoryRepository: repository).call(
      getDepartmentPrarams: GetDepartmentPrarams(
          kind: kind,
          type: type,
          token: await secureStorage.read(key: 'token') ?? ''),
    );

    failureOrCategory.fold(
      (Failure newFailure) {
        _isLoading = false;
        listDepartment = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<DepartmentEntity>> response) {
        isLoading = false;
        listDepartment = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetSubclicServices(String key) async {
    listSubclinicServices = [];
    _isLoading = true;
    CategoryRepositoryImpl repository = CategoryRepositoryImpl(
      remoteDataSource: CategoryRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: CategoryLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrCategory =
        await GetSubclinicServiceUsecase(categoryRepository: repository).call(
      getSubclinicServicePrarams: GetSubclinicServicePrarams(
          key: key, token: await secureStorage.read(key: 'token') ?? ''),
    );

    failureOrCategory.fold(
      (Failure newFailure) {
        _isLoading = false;
        listSubclinicServices = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<SubclinicServiceEntity>> response) {
        isLoading = false;
        listSubclinicServices = response.data;
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
