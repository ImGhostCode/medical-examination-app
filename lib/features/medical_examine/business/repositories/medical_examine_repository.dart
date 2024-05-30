import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class MedicalExamineRepository {
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> loadSignals({
    required LoadSignalParams loadSignalParams,
  });
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> getEnteredSignals({
    required GetEnteredSignalParams getEnteredSignalParams,
  });
  Future<Either<Failure, ResponseModel<List<StreatmentSheetEntity>>>>
      getEnteredStreatmentSheets({
    required GetEnteredStreamentSheetParams getEnteredStreamentSheetParams,
  });
  Future<Either<Failure, ResponseModel<List<CareSheetEntity>>>>
      getEnteredCareSheets({
    required GetEnteredCareSheetParams getEnteredCareSheetParams,
  });
}
