import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../user/business/entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<Either<Failure, ResponseModel<UserEntity>>> call({
    required LoginParams loginParams,
  }) async {
    return await authRepository.login(loginParams: loginParams);
  }
}
