import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class CreCareSheetUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  CreCareSheetUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<String>>> call({
    required CreateCareSheetParams createCareSheetParams,
  }) async {
    return await medicalExamineRepository.createCareSheet(
      createCareSheetParams: createCareSheetParams,
    );
  }
}
