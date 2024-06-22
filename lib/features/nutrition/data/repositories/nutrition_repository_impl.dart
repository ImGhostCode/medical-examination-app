import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/features/nutrition/data/models/nutrition_model.dart';
import 'package:medical_examination_app/features/nutrition/data/models/nutrition_order_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/nutrition_repository.dart';
import '../datasources/nutrition_local_data_source.dart';
import '../datasources/nutrition_remote_data_source.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource remoteDataSource;
  final NutritionLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NutritionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseModel<List<NutritionModel>>>> getNutritions(
      {required GetNutritionParams getNutritionParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<NutritionModel>> remoteNutrition =
            await remoteDataSource.getNutritions(
                getNutritionParams: getNutritionParams);

        // localDataSource.cacheCategory(templateToCache: remoteNutrition);

        return Right(remoteNutrition);
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
  Future<Either<Failure, ResponseModel<List<NutritionOrderModel>>>>
      getNutritionOrders(
          {required GetNutritionOrderParams getNutritionOrderParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<NutritionOrderModel>> remoteNutrition =
            await remoteDataSource.getNutritionOrders(
                getNutritionOrderParams: getNutritionOrderParams);

        // localDataSource.cacheCategory(templateToCache: remoteNutrition);

        return Right(remoteNutrition);
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
