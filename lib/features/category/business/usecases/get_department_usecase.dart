import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/category_repository.dart';

class GetDepartmentUsecase {
  final CategoryRepository categoryRepository;

  GetDepartmentUsecase({required this.categoryRepository});

  Future<Either<Failure, ResponseModel<List<DepartmentEntity>>>> call({
    required GetDepartmentPrarams getDepartmentPrarams,
  }) async {
    return await categoryRepository.getDepartments(
        getDepartmentPrarams: getDepartmentPrarams);
  }
}
