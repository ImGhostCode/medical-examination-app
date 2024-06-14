import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';
import 'package:medical_examination_app/features/patient/business/usecases/get_patient_info_usecase.dart';
import 'package:medical_examination_app/features/patient/business/usecases/get_patient_serv_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/usecases/get_patient_in_room_usecase.dart';
import '../../data/datasources/patient_local_data_source.dart';
import '../../data/datasources/patient_remote_data_source.dart';
import '../../data/repositories/patient_repository_impl.dart';
import 'package:tiengviet/tiengviet.dart';

final FlutterSecureStorage secureStorage = SecureStorageService.secureStorage;

class PatientProvider extends ChangeNotifier {
  String code;
  String type;
  String status;
  String message;

  List<InRoomPatientEntity> listPatientInRoom;
  List<InRoomPatientEntity> listRenderPatientInRoom = [];
  List<PatientServiceEntity> listPatientServices = [];

  PatientEntity? patientInfo;

  Failure? failure;

  bool _isLoading = false;
  bool isLoadingServices = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PatientProvider({
    this.code = '',
    this.type = '',
    this.status = '',
    this.message = '',
    this.listPatientInRoom = const [],
    this.failure,
  });

  void eitherFailureOrGetPatientInRoom(String location, String status,
      String from, String to, bool activeNewIp, String? kind) async {
    listPatientInRoom = [];
    _isLoading = true;
    PatientRepositoryImpl repository = PatientRepositoryImpl(
      remoteDataSource: PatientRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: PatientLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrPatient =
        await GetPatientInRoomUsecase(patientRepository: repository).call(
      getPatientInRoomParams: GetPatientInRoomParams(
        location: location,
        status: status,
        from: from,
        to: to,
        activeNewIp: activeNewIp,
        kind: kind,
        token: await secureStorage.read(key: 'token') ?? '',
      ),
    );

    failureOrPatient.fold(
      (Failure newFailure) {
        _isLoading = false;
        listPatientInRoom = [];
        listRenderPatientInRoom = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<InRoomPatientEntity>> response) {
        _isLoading = false;
        listPatientInRoom = response.data;
        listRenderPatientInRoom = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetPatientInfo(String type, int encounter) async {
    patientInfo = null;
    _isLoading = true;
    PatientRepositoryImpl repository = PatientRepositoryImpl(
      remoteDataSource: PatientRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: PatientLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrPatient =
        await GetPatientInfoUsecase(patientRepository: repository).call(
      getPatientInfoParams: GetPatientInfoParams(
        type: type,
        encounter: encounter,
        token: await secureStorage.read(key: 'token') ?? '',
      ),
    );

    failureOrPatient.fold(
      (Failure newFailure) {
        _isLoading = false;
        patientInfo = null;
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<PatientEntity> response) {
        _isLoading = false;
        patientInfo = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrGetPatientServices(String type, int encounter) async {
    listPatientServices = [];
    isLoadingServices = true;
    PatientRepositoryImpl repository = PatientRepositoryImpl(
      remoteDataSource: PatientRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: PatientLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        InternetConnectionChecker(),
      ),
    );

    final failureOrPatient =
        await GetPatientServiceUsecase(patientRepository: repository).call(
      getPatientServiceParams: GetPatientServiceParams(
        type: type,
        encounter: encounter,
        token: await secureStorage.read(key: 'token') ?? '',
      ),
    );

    failureOrPatient.fold(
      (Failure newFailure) {
        isLoadingServices = false;
        listPatientServices = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseModel<List<PatientServiceEntity>> response) {
        isLoadingServices = false;
        listPatientServices = response.data;
        code = response.code;
        type = response.type;
        status = response.status;
        message = response.message;
        failure = null;
        notifyListeners();
      },
    );
  }

  void searchPatientInRoom(String key) async {
    key = TiengViet.parse(key);
    listRenderPatientInRoom = listPatientInRoom
        .where((element) => (TiengViet.parse(element.name.toLowerCase())
                .contains(key.toLowerCase()) ||
            element.subject.toString().contains(key)))
        .toList();
    notifyListeners();
  }
}
