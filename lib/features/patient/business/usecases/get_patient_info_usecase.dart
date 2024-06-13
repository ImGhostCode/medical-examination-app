import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/patient_repository.dart';

class GetPatientInfoUsecase {
  final PatientRepository patientRepository;

  GetPatientInfoUsecase({required this.patientRepository});

  Future<Either<Failure, ResponseModel<PatientEntity>>> call({
    required GetPatientInfoParams getPatientInfoParams,
  }) async {
    return await patientRepository.getPatientInfo(
      getPatientInfoParams: getPatientInfoParams,
    );
  }
}
