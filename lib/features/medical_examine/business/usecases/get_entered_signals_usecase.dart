import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class GetEnteredSignalsUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  GetEnteredSignalsUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> call({
    required GetEnteredSignalParams getEnteredSignalParams,
  }) async {
    return await medicalExamineRepository.getEnterdSignals(
      getEnteredSignalParams: getEnteredSignalParams,
    );
  }
}
