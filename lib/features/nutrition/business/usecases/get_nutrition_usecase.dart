import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionUsecase {
  final NutritionRepository nutritionRepository;

  GetNutritionUsecase({required this.nutritionRepository});

  Future<Either<Failure, ResponseModel<List<NutritionEntity>>>> call({
    required GetNutritionParams getNutritrionParams,
  }) async {
    return await nutritionRepository.getNutritions(
        getNutritionParams: getNutritrionParams);
  }
}
