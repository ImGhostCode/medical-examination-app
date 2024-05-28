import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class PatientRepository {
  Future<Either<Failure, ResponseModel<List<InRoomPatientEntity>>>>
      getPatientsInRoom({
    required GetPatientInRoomParams getPatientInRoomParams,
  });
}
