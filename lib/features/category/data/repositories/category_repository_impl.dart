import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/data/models/department_model.dart';
import 'package:medical_examination_app/features/category/data/models/icd_model.dart';
import 'package:medical_examination_app/features/category/data/models/subcli_serv_group_model.dart';
import 'package:medical_examination_app/features/category/data/models/subclinic_service_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseModel<List<DepartmentModel>>>> getDepartments(
      {required GetDepartmentPrarams getDepartmentPrarams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<DepartmentModel>> remoteCategory =
            await remoteDataSource.getDepartments(
                getDepartmentPrarams: getDepartmentPrarams);

        // localDataSource.cacheCategory(templateToCache: remoteCategory);

        return Right(remoteCategory);
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
  Future<Either<Failure, ResponseModel<List<SubclinicServiceModel>>>>
      getSubclinicServices(
          {required GetSubclinicServicePrarams
              getSubclinicServicePrarams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<SubclinicServiceModel>> remoteCategory =
            await remoteDataSource.getSubclinicServices(
                getSubclinicServicePrarams: getSubclinicServicePrarams);

        // localDataSource.cacheCategory(templateToCache: remoteCategory);

        return Right(remoteCategory);
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
  Future<Either<Failure, ResponseModel<List<SubcliServGroupModel>>>>
      getSubclinicServiceGroups(
          {required GetSubclinicServiceGroupPrarams
              getSubclinicServiceGroupPrarams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<List<SubcliServGroupModel>> remoteCategory =
            await remoteDataSource.getSubclinicServiceGroups(
                getSubclinicServiceGroupPrarams:
                    getSubclinicServiceGroupPrarams);

        // localDataSource.cacheCategory(templateToCache: remoteCategory);

        return Right(remoteCategory);
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
  Future<Either<Failure, ResponseModel<List<ICDModel>>>> getICD(
      {required GetICDPrarams getICDPrarams}) async {
    if (await networkInfo.isConnected!) {
      try {
        try {
          ResponseModel<List<ICDModel>> listICDCached =
              await localDataSource.getLastICD();

          if (listICDCached.data.isNotEmpty) {
            return Right(listICDCached);
          }
        } catch (e) {
          print(e);
        }

        ResponseModel<List<ICDModel>> remoteICD =
            await remoteDataSource.getICD(getICDPrarams: getICDPrarams);

        localDataSource.cacheICD(icdToCache: remoteICD);

        return Right(remoteICD);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          code: e.code.toString(),
          errorMessage: e.message,
          status: e.status,
        ));
      }
    } else {
      try {
        ResponseModel<List<ICDModel>> listICDCached =
            await localDataSource.getLastICD();
        return Right(listICDCached);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
