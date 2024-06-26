import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/category_params.dart';
import 'package:medical_examination_app/features/category/business/entities/icd_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/department_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/subclinic_service_entity.dart';
import 'package:medical_examination_app/features/category/business/entities/sublin_serv_group_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, ResponseModel<List<DepartmentEntity>>>>
      getDepartments({
    required GetDepartmentPrarams getDepartmentPrarams,
  });
  Future<Either<Failure, ResponseModel<List<SublicServGroupEntity>>>>
      getSubclinicServiceGroups({
    required GetSubclinicServiceGroupPrarams getSubclinicServiceGroupPrarams,
  });
  Future<Either<Failure, ResponseModel<List<SubclinicServiceEntity>>>>
      getSubclinicServices({
    required GetSubclinicServicePrarams getSubclinicServicePrarams,
  });
  Future<Either<Failure, ResponseModel<List<ICDEntity>>>> getICD({
    required GetICDPrarams getICDPrarams,
  });
}
