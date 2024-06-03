import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/cre_care_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/cre_streatment_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/edit_care_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/edit_streatment_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/get_entered_care_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/get_entered_signals_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/get_entered_streatm_sheet_usecase.dart';
import 'package:medical_examination_app/features/medical_examine/business/usecases/modify_signal_usecase.dart';
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
  // String modifyResult;

  List<SignalEntity> listSignals;
  List<SignalEntity> listEnteredSignals;
  List<StreatmentSheetEntity> listEnteredStreatmentSheets;
  List<CareSheetEntity> listEnteredCareSheets;
  Failure? failure;
  Failure? failureSignal;
  Failure? failureStreatmentSheet;
  Failure? failureCareSheet;

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
    this.listEnteredStreatmentSheets = const [],
    this.listEnteredCareSheets = const [],
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

  Future<List<SignalEntity>> eitherFailureOrGetEnteredSignals(
      String type, String encounter) async {
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
    return listEnteredSignals;
  }

  void eitherFailureOrGetEnteredStreatSheets(
      String type, String encounter) async {
    listEnteredStreatmentSheets = [];
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

    final failureOrTemplate = await GetEnteredStreatmentSheetUsecase(
            medicalExamineRepository: repository)
        .call(
            getEnteredStreamentSheetParams: GetEnteredStreamentSheetParams(
      type: type,
      encounter: encounter,
      token: await secureStorage.read(key: 'token') ?? '',
    ));

    failureOrTemplate.fold(
      (Failure newFailure) {
        _isLoading = false;
        listEnteredStreatmentSheets = [];
        failureStreatmentSheet = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<StreatmentSheetEntity>> response) {
        _isLoading = false;
        listEnteredStreatmentSheets = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failureStreatmentSheet = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetEnteredCareSheets(
      String type, String encounter) async {
    listEnteredCareSheets = [];
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
        await GetEnteredCareSheetUsecase(medicalExamineRepository: repository)
            .call(
                getEnteredCareSheetParams: GetEnteredCareSheetParams(
      type: type,
      encounter: encounter,
      token: await secureStorage.read(key: 'token') ?? '',
    ));

    failureOrTemplate.fold(
      (Failure newFailure) {
        _isLoading = false;
        listEnteredCareSheets = [];
        failureCareSheet = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<CareSheetEntity>> response) {
        _isLoading = false;
        listEnteredCareSheets = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failureCareSheet = null;
        notifyListeners();
      },
    );
  }

  dynamic eitherFailureOrModifySignal(SignalEntity signal, final int encounter,
      final int? request, final int? division) async {
    isLoading = true;
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

    final failureOModifySignal =
        await ModifySignalUsecase(medicalExamineRepository: repository).call(
            modifySignalParams: ModifySignalParams(
      encounter: encounter,
      token: await secureStorage.read(key: 'token') ?? '',
      data: signal,
      ip: '',
      code: '',
    ));

    var result = failureOModifySignal.fold(
      (Failure newFailure) {
        isLoading = false;
        // modifyResult = '';
        // failure = newFailure;
        notifyListeners();
        return newFailure; // return false in case of failure
      },
      (ResponseModel<String> response) {
        isLoading = false;
        // modifyResult = response.data;
        // code = response.code;
        // type = response.type;
        // status = response.status;
        // message = response.message;
        // failure = null;
        notifyListeners();
        return response; // return true in case of success
      },
    );
    return result;
  }

  dynamic eitherFailureOrCreStreatmentSheet(
      StreatmentSheetEntity streatmentSheet, int division) async {
    isLoading = true;
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

    final failureOrCreStreatmentSheet =
        await CreStreatmentSheetUsecase(medicalExamineRepository: repository)
            .call(
                createStreatmentSheetParams: CreateStreatmentSheetParams(
      division: division.toString(),
      token: await secureStorage.read(key: 'token') ?? '',
      data: streatmentSheet,
      ip: '192:168:1:18',
      code: 'ad568891-dbc4-4241-a122-abb127901972',
    ));

    var result = failureOrCreStreatmentSheet.fold(
      (Failure newFailure) {
        isLoading = false;
        // modifyResult = '';
        // failure = newFailure;
        notifyListeners();
        return newFailure; // return false in case of failure
      },
      (ResponseModel<String> response) {
        isLoading = false;
        // modifyResult = response.data;
        // code = response.code;
        // type = response.type;
        // status = response.status;
        // message = response.message;
        // failure = null;
        notifyListeners();
        return response; // return true in case of success
      },
    );
    return result;
  }

  dynamic eitherFailureOrEditStreatmentSheet(
      StreatmentSheetEntity streatmentSheet, int request) async {
    isLoading = true;
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

    final failureOrEditStreatmentSheet =
        await EditStreatmentSheetUsecase(medicalExamineRepository: repository)
            .call(
                editStreatmentSheetParams: EditStreatmentSheetParams(
      request: request,
      token: await secureStorage.read(key: 'token') ?? '',
      data: streatmentSheet,
      ip: '192:168:1:18',
      code: 'ad568891-dbc4-4241-a122-abb127901972',
    ));

    var result = failureOrEditStreatmentSheet.fold(
      (Failure newFailure) {
        isLoading = false;
        // modifyResult = '';
        // failure = newFailure;
        notifyListeners();
        return newFailure; // return false in case of failure
      },
      (ResponseModel<String?> response) {
        isLoading = false;
        // modifyResult = response.data;
        // code = response.code;
        // type = response.type;
        // status = response.status;
        // message = response.message;
        // failure = null;
        notifyListeners();
        return response; // return true in case of success
      },
    );
    return result;
  }

  dynamic eitherFailureOrCreCareSheet(
      CareSheetEntity streatmentSheet, int division) async {
    isLoading = true;
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

    final failureOrCreCareSheet =
        await CreCareSheetUsecase(medicalExamineRepository: repository).call(
            createCareSheetParams: CreateCareSheetParams(
      division: division.toString(),
      token: await secureStorage.read(key: 'token') ?? '',
      data: streatmentSheet,
      ip: '192:168:1:18',
      code: 'ad568891-dbc4-4241-a122-abb127901972',
    ));

    var result = failureOrCreCareSheet.fold(
      (Failure newFailure) {
        isLoading = false;
        // modifyResult = '';
        // failure = newFailure;
        notifyListeners();
        return newFailure; // return false in case of failure
      },
      (ResponseModel<String> response) {
        isLoading = false;
        // modifyResult = response.data;
        // code = response.code;
        // type = response.type;
        // status = response.status;
        // message = response.message;
        // failure = null;
        notifyListeners();
        return response; // return true in case of success
      },
    );
    return result;
  }

  dynamic eitherFailureOrEditCareSheet(
      CareSheetEntity careSheet, int request) async {
    isLoading = true;
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

    final failureOrEditCareSheet =
        await EditCareSheetUsecase(medicalExamineRepository: repository).call(
            editCareSheetParams: EditCareSheetParams(
      request: request,
      token: await secureStorage.read(key: 'token') ?? '',
      data: careSheet,
      ip: '192:168:1:18',
      code: 'ad568891-dbc4-4241-a122-abb127901972',
    ));

    var result = failureOrEditCareSheet.fold(
      (Failure newFailure) {
        isLoading = false;
        // modifyResult = '';
        // failure = newFailure;
        notifyListeners();
        return newFailure; // return false in case of failure
      },
      (ResponseModel<String?> response) {
        isLoading = false;
        // modifyResult = response.data;
        // code = response.code;
        // type = response.type;
        // status = response.status;
        // message = response.message;
        // failure = null;
        notifyListeners();
        return response; // return true in case of success
      },
    );
    return result;
  }
}
