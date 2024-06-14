import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/data/models/in_room_patient_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_model.dart';
import 'package:medical_examination_app/features/patient/data/models/patient_service_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/patient_repository.dart';
import '../datasources/patient_local_data_source.dart';
import '../datasources/patient_remote_data_source.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource remoteDataSource;
  final PatientLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PatientRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseModel<List<InRoomPatientModel>>>>
      getPatientsInRoom(
          {required GetPatientInRoomParams getPatientInRoomParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<InRoomPatientModel>> remotePatient =
            await remoteDataSource.getPatientsInRoom(
                getPatientInRoomParams: getPatientInRoomParams);

        // localDataSource.cachePatient(templateToCache: remotePatient);

        return Right(remotePatient);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          code: e.code.toString(),
          errorMessage: e.message,
          status: e.status,
        ));
      }
    } else {
      // try {
      // AuthModel localAuth = await localDataSource.getLastAuth();
      // return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseModel<PatientModel>>> getPatientInfo(
      {required GetPatientInfoParams getPatientInfoParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<PatientModel> remotePatient = await remoteDataSource
            .getPatientInfo(getPatientInfoParams: getPatientInfoParams);

        // localDataSource.cachePatient(templateToCache: remotePatient);

        return Right(remotePatient);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          code: e.code.toString(),
          errorMessage: e.message,
          status: e.status,
        ));
      }
    } else {
      // try {
      // AuthModel localAuth = await localDataSource.getLastAuth();
      // return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      // }
    }
  }

  @override
  Future<Either<Failure, ResponseModel<List<PatientServiceModel>>>>
      getPatientServices(
          {required GetPatientServiceParams getPatientServiceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<PatientServiceModel>> remotePatient =
            await remoteDataSource.getPatientServices(
                getPatientServiceParams: getPatientServiceParams);

        // localDataSource.cachePatient(templateToCache: remotePatient);

        return Right(remotePatient);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          code: e.code.toString(),
          errorMessage: e.message,
          status: e.status,
        ));
      }
    } else {
      // try {
      // AuthModel localAuth = await localDataSource.getLastAuth();
      // return Right(localAuth);
      // } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      // }
    }
  }
}
