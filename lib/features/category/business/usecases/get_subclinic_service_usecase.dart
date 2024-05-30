import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/category_repository.dart';

class GetSubclinicServiceUsecase {
  final CategoryRepository categoryRepository;

  GetSubclinicServiceUsecase({required this.categoryRepository});

  Future<Either<Failure, ResponseModel<List<SubclinicServiceEntity>>>> call({
    required GetSubclinicServicePrarams getSubclinicServicePrarams,
  }) async {
    return await categoryRepository.getSubclinicServices(
      getSubclinicServicePrarams: getSubclinicServicePrarams,
    );
  }
}
