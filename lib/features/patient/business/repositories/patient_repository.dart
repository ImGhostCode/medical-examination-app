import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_ser_pub_res_entity.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class PatientRepository {
  Future<Either<Failure, ResponseModel<List<InRoomPatientEntity>>>>
      getPatientsInRoom({
    required GetPatientInRoomParams getPatientInRoomParams,
  });
  Future<Either<Failure, ResponseModel<PatientEntity>>> getPatientInfo({
    required GetPatientInfoParams getPatientInfoParams,
  });
  Future<Either<Failure, ResponseModel<List<PatientServiceEntity>>>>
      getPatientServices({
    required GetPatientServiceParams getPatientServiceParams,
  });

  Future<Either<Failure, ResponseModel<List<PatientSerPubResEntity>>>>
      publishPatientServices({
    required PublishPatientServiceParams publishPatientServiceParams,
  });
}
