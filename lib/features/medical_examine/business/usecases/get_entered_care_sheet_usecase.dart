import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class GetEnteredCareSheetUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  GetEnteredCareSheetUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<CareSheetEntity>>>> call({
    required GetEnteredCareSheetParams getEnteredCareSheetParams,
  }) async {
    return await medicalExamineRepository.getEnteredCareSheets(
      getEnteredCareSheetParams: getEnteredCareSheetParams,
    );
  }
}
