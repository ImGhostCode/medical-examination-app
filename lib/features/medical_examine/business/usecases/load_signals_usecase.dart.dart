import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/medical_examine_repository.dart';

class LoadSignalsUsecase {
  final MedicalExamineRepository medicalExamineRepository;

  LoadSignalsUsecase({required this.medicalExamineRepository});

  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> call({
    required LoadSignalParams loadSignalParams,
  }) async {
    return await medicalExamineRepository.loadSignals(
        loadSignalParams: loadSignalParams);
  }
}
