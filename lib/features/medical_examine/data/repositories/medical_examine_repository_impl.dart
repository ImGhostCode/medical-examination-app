import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';

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
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> getEnterdSignals(
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
}
