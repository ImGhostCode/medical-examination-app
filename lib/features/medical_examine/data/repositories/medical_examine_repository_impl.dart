import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/care_sheet_model.dart';
import 'package:medical_examination_app/features/medical_examine/data/models/streatment_sheet_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/medical_examine_repository.dart';
import '../datasources/medical_local_data_source.dart';
import '../datasources/medical_remote_data_source.dart';

class MedicalExamineRepositoryImpl implements MedicalExamineRepository {
  final MedicalExamineRemoteDataSource remoteDataSource;
  final MedicalExamineLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MedicalExamineRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> loadSignals(
      {required LoadSignalParams loadSignalParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<SignalEntity>> remoteMedicalExamine =
            await remoteDataSource.loadSignals(
                loadSignalParams: loadSignalParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> getEnteredSignals(
      {required GetEnteredSignalParams getEnteredSignalParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<SignalEntity>> remoteMedicalExamine =
            await remoteDataSource.getEnteredSignals(
                getEnteredSignalParams: getEnteredSignalParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<List<StreatmentSheetModel>>>>
      getEnteredStreatmentSheets(
          {required GetEnteredStreamentSheetParams
              getEnteredStreamentSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<StreatmentSheetModel>> remoteMedicalExamine =
            await remoteDataSource.getEnteredStreatmentSheets(
                getEnteredStreamentSheetParams: getEnteredStreamentSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<List<CareSheetEntity>>>>
      getEnteredCareSheets(
          {required GetEnteredCareSheetParams
              getEnteredCareSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<CareSheetModel>> remoteMedicalExamine =
            await remoteDataSource.getEnteredCareSheets(
                getEnteredCareSheetParams: getEnteredCareSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<String>>> modifySignal(
      {required ModifySignalParams modifySignalParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<String> remoteMedicalExamine = await remoteDataSource
            .modifySignal(modifySignalParams: modifySignalParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<String>>> createStreatmentSheet(
      {required CreateStreatmentSheetParams
          createStreatmentSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<String> remoteMedicalExamine =
            await remoteDataSource.creStreatmentSheet(
                createStreatmentSheetParams: createStreatmentSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<String>>> createCareSheet(
      {required CreateCareSheetParams createCareSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<String> remoteMedicalExamine = await remoteDataSource
            .creCareSheet(createCareSheetParams: createCareSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<String?>>> editStreatmentSheet(
      {required EditStreatmentSheetParams editStreatmentSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<String?> remoteMedicalExamine =
            await remoteDataSource.editStreatmentSheet(
                editStreatmentSheetParams: editStreatmentSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
  Future<Either<Failure, ResponseModel<String?>>> editCareSheet(
      {required EditCareSheetParams editCareSheetParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<String?> remoteMedicalExamine = await remoteDataSource
            .editCareSheet(editCareSheetParams: editCareSheetParams);

        // localDataSource.cachePatient(templateToCache: remoteMedicalExamine);

        return Right(remoteMedicalExamine);
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
