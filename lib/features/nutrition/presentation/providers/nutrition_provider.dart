import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/core/services/shared_pref_service.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import 'package:medical_examination_app/features/nutrition/business/usecases/get_nutrition_order_usecase.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/usecases/get_nutrition_usecase.dart';
import '../../data/datasources/nutrition_local_data_source.dart';
import '../../data/datasources/nutrition_remote_data_source.dart';
import '../../data/repositories/nutrition_repository_impl.dart';

final FlutterSecureStorage secureStorage = SecureStorageService.secureStorage;

class NutritionProvider extends ChangeNotifier {
  String code;
  String type;
  String status;
  String message;
  List<NutritionEntity> nutritions = [];
  List<NutritionOrderEntity> nutritionOrders = [];

  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  NutritionProvider({
    this.nutritions = const [],
    this.failure,
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
  });

  void eitherFailureOrGetNutritions() async {
    nutritions = [];
    _isLoading = true;
    NutritionRepositoryImpl repository = NutritionRepositoryImpl(
      remoteDataSource: NutritionRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: NutritionLocalDataSourceImpl(
        sharedPreferences: SharedPrefService.prefs,
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrNutritions =
        await GetNutritionUsecase(nutritionRepository: repository).call(
      getNutritrionParams: GetNutritionParams(
          key: 'nutrition',
          token: await secureStorage.read(key: 'token') ?? ''),
    );

    failureOrNutritions.fold(
      (Failure newFailure) {
        _isLoading = false;
        nutritions = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<NutritionEntity>> response) {
        _isLoading = false;
        nutritions = response.data;
        failure = null;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetNutritionOrders(
      String status, dynamic org, String from, String to) async {
    nutritionOrders = [];
    _isLoading = true;
    NutritionRepositoryImpl repository = NutritionRepositoryImpl(
      remoteDataSource: NutritionRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: NutritionLocalDataSourceImpl(
        sharedPreferences: SharedPrefService.prefs,
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrNutritionOrders =
        await GetNutritionOrderUsecase(nutritionRepository: repository).call(
      getNutritionOrderParams: GetNutritionOrderParams(
          status: status,
          org: org,
          from: from,
          to: to,
          token: await secureStorage.read(key: 'token') ?? ''),
    );

    failureOrNutritionOrders.fold(
      (Failure newFailure) {
        _isLoading = false;
        nutritionOrders = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<NutritionOrderEntity>> response) {
        _isLoading = false;
        nutritionOrders = response.data;
        failure = null;
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
