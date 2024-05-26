import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../user/business/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseModel<UserEntity>>> login({
    required LoginParams loginParams,
  });
}
