import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class EditStreatmentSheetUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  EditStreatmentSheetUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<String?>>> call({
    required EditStreatmentSheetParams editStreatmentSheetParams,
  }) async {
    return await medicalExamineRepository.editStreatmentSheet(
      editStreatmentSheetParams: editStreatmentSheetParams,
    );
  }
}
