import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/sublin_serv_group_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/category_repository.dart';

class GetSubcliServGroupUsecase {
  final CategoryRepository categoryRepository;

  GetSubcliServGroupUsecase({required this.categoryRepository});

  Future<Either<Failure, ResponseModel<List<SublicServGroupEntity>>>> call({
    required GetSubclinicServiceGroupPrarams getSubclinicServiceGroupPrarams,
  }) async {
    return await categoryRepository.getSubclinicServiceGroups(
      getSubclinicServiceGroupPrarams: getSubclinicServiceGroupPrarams,
    );
  }
}
