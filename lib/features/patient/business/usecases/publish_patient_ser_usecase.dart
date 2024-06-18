import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/patient_params.dart';
import 'package:medical_examination_app/features/patient/business/entities/patient_ser_pub_res_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/patient_repository.dart';

class PublishPatientServiceUsecase {
  final PatientRepository patientRepository;

  PublishPatientServiceUsecase({required this.patientRepository});

  Future<Either<Failure, ResponseModel<List<PatientSerPubResEntity>>>> call({
    required PublishPatientServiceParams publishPatientServiceParams,
  }) async {
    return await patientRepository.publishPatientServices(
      publishPatientServiceParams: publishPatientServiceParams,
    );
  }
}
