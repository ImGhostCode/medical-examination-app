import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/get_entered_signals_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/usecases/load_signals_usecase.dart.dart';
import '../../data/datasources/medical_local_data_source.dart';
import '../../data/datasources/medical_remote_data_source.dart';
import '../../data/repositories/medical_examine_repository_impl.dart';

final FlutterSecureStorage secureStorage = SecureStorageService.secureStorage;

class MedicalExamineProvider extends ChangeNotifier {
  String code;
  String type;
  String status;
  String message;

  List<SignalEntity> listSignals;
  List<SignalEntity> listEnteredSignals;
  Failure? failure;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  MedicalExamineProvider({
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
    this.listSignals = const [],
    this.listEnteredSignals = const [],
    this.failure,
  });

  void eitherFailureOrLoadSignals(
      List<SignalParamItem> loadSignalParams) async {
    listSignals = [];
    _isLoading = true;
    MedicalExamineRepositoryImpl repository = MedicalExamineRepositoryImpl(
      remoteDataSource: MedicalExamineRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: MedicalExamineLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrTemplate =
        await LoadSignalsUsecase(medicalExamineRepository: repository).call(
            loadSignalParams: LoadSignalParams(
      loadSignalParams: loadSignalParams,
      token: await secureStorage.read(key: 'token') ?? '',
    ));

    failureOrTemplate.fold(
      (Failure newFailure) {
        _isLoading = false;
        listSignals = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<SignalEntity>> response) {
        _isLoading = false;
        listSignals = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetEnteredSignals(String type, String encounter) async {
    listEnteredSignals = [];
    _isLoading = true;
    MedicalExamineRepositoryImpl repository = MedicalExamineRepositoryImpl(
      remoteDataSource: MedicalExamineRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: MedicalExamineLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrTemplate =
        await GetEnteredSignalsUsecase(medicalExamineRepository: repository)
            .call(
                getEnteredSignalParams: GetEnteredSignalParams(
      type: type,
      encounter: encounter,
      token: await secureStorage.read(key: 'token') ?? '',
    ));

    failureOrTemplate.fold(
      (Failure newFailure) {
        _isLoading = false;
        listEnteredSignals = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<SignalEntity>> response) {
        _isLoading = false;
        listEnteredSignals = response.data;
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
