import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/auth_repository.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../user/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseModel<UserModel>>> login(
      {required LoginParams loginParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseModel<UserModel> remoteAuth =
            await remoteDataSource.login(loginParams: loginParams);

        // localDataSource.cacheAuth(templateToCache: remoteAuth);

        return Right(remoteAuth);
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
