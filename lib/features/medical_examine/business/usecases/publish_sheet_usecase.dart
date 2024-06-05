import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class PublishSheetUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  PublishSheetUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<String?>>> call({
    required PublishMedicalSheetParams publishMedicalSheetParams,
  }) async {
    return await medicalExamineRepository.publishMedicalSheet(
      publishMedicalSheetParams: publishMedicalSheetParams,
    );
  }
}
