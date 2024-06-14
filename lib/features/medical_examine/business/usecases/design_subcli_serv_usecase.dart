import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/subclinic_designation_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class DesignSubcliServUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  DesignSubcliServUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<SubclinicDesignationEntity>>>>
      call({
    required SubclinicServDesignationParams subclinicServDesignationParams,
  }) async {
    return await medicalExamineRepository.designSubclinicService(
      subclinicServDesignationParams: subclinicServDesignationParams,
    );
  }
}
