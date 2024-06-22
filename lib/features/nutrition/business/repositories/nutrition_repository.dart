import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';
import '../../../../../core/errors/failure.dart';

abstract class NutritionRepository {
  Future<Either<Failure, ResponseModel<List<NutritionEntity>>>> getNutritions({
    required GetNutritionParams getNutritionParams,
  });
  Future<Either<Failure, ResponseModel<List<NutritionOrderEntity>>>>
      getNutritionOrders({
    required GetNutritionOrderParams getNutritionOrderParams,
  });
}
