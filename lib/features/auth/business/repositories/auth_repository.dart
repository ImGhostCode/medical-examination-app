import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/auth_params.dart';
import '../../../../../core/errors/failure.dart';
import '../../../user/business/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseModel<UserEntity>>> login({
    required LoginParams loginParams,
  });
}
