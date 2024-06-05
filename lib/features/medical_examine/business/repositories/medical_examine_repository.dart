import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/medical_examine_params.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/care_sheet_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/signal_entity.dart';
import 'package:medical_examination_app/features/medical_examine/business/entities/streatment_sheet_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class MedicalExamineRepository {
  // Sinh hiệu
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> loadSignals({
    required LoadSignalParams loadSignalParams,
  });
  Future<Either<Failure, ResponseModel<List<SignalEntity>>>> getEnteredSignals({
    required GetEnteredSignalParams getEnteredSignalParams,
  });
  Future<Either<Failure, ResponseModel<String>>> modifySignal({
    required ModifySignalParams modifySignalParams,
  });

// Tờ điều trị
  Future<Either<Failure, ResponseModel<List<StreatmentSheetEntity>>>>
      getEnteredStreatmentSheets({
    required GetEnteredStreamentSheetParams getEnteredStreamentSheetParams,
  });
  Future<Either<Failure, ResponseModel<String>>> createStreatmentSheet({
    required CreateStreatmentSheetParams createStreatmentSheetParams,
  });
  Future<Either<Failure, ResponseModel<String?>>> editStreatmentSheet({
    required EditStreatmentSheetParams editStreatmentSheetParams,
  });

// Tờ chăm sóc
  Future<Either<Failure, ResponseModel<List<CareSheetEntity>>>>
      getEnteredCareSheets({
    required GetEnteredCareSheetParams getEnteredCareSheetParams,
  });
  Future<Either<Failure, ResponseModel<String>>> createCareSheet({
    required CreateCareSheetParams createCareSheetParams,
  });
  Future<Either<Failure, ResponseModel<String?>>> editCareSheet({
    required EditCareSheetParams editCareSheetParams,
  });
// Ban hành
  Future<Either<Failure, ResponseModel<String?>>> publishMedicalSheet({
    required PublishMedicalSheetParams publishMedicalSheetParams,
  });
}
