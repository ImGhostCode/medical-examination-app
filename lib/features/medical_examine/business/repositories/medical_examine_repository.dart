import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class MedicalExamineRepository {
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> loadSignals({
    required LoadSignalParams loadSignalParams,
  });
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> getEnterdSignals({
    required GetEnteredSignalParams getEnteredSignalParams,
  });
}
