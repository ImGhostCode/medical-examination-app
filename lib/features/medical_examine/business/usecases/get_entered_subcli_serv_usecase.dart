import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class GetEnteredSubcliServUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  GetEnteredSubcliServUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<SubclinicServiceEntity>>>> call({
    required GetEnteredSubclinicServicePrarams
        getEnteredSubclinicServicePrarams,
  }) async {
    return await medicalExamineRepository.getEnteredSubclinicService(
      getEnteredSubclinicServicePrarams: getEnteredSubclinicServicePrarams,
    );
  }
}
