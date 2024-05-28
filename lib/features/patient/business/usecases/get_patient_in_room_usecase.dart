import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/in_room_patient_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/patient_repository.dart';

class GetPatientInRoomUsecase {
  final PatientRepository patientRepository;

  GetPatientInRoomUsecase({required this.patientRepository});

  Future<Either<Failure, ResponseModel<List<InRoomPatientEntity>>>> call({
    required GetPatientInRoomParams getPatientInRoomParams,
  }) async {
    return await patientRepository.getPatientsInRoom(
      getPatientInRoomParams: getPatientInRoomParams,
    );
  }
}
