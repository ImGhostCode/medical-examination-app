import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class GetEnteredStreatmentSheetUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  GetEnteredStreatmentSheetUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<StreatmentSheetEntity>>>> call({
    required GetEnteredStreamentSheetParams getEnteredStreamentSheetParams,
  }) async {
    return await medicalExamineRepository.getEnteredStreatmentSheets(
      getEnteredStreamentSheetParams: getEnteredStreamentSheetParams,
    );
  }
}
