import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/icd_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/category_repository.dart';

class GetICDUsecase {
  final CategoryRepository categoryRepository;

  GetICDUsecase({required this.categoryRepository});

  Future<Either<Failure, ResponseModel<List<ICDEntity>>>> call({
    required GetICDPrarams getICDPrarams,
  }) async {
    return await categoryRepository.getICD(getICDPrarams: getICDPrarams);
  }
}
