import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_service_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/patient_repository.dart';

class GetPatientServiceUsecase {
  final PatientRepository patientRepository;

  GetPatientServiceUsecase({required this.patientRepository});

  Future<Either<Failure, ResponseModel<List<PatientServiceEntity>>>> call({
    required GetPatientServiceParams getPatientServiceParams,
  }) async {
    return await patientRepository.getPatientServices(
      getPatientServiceParams: getPatientServiceParams,
    );
  }
}
