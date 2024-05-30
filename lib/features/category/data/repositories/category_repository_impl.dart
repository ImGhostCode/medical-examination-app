import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/data/models/department_model.dart';
import 'package:medical_examination_app/features/category/data/models/subclinic_service_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../business/repositories/category_repository.dart';
import '../datasources/template_local_data_source.dart';
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
}
