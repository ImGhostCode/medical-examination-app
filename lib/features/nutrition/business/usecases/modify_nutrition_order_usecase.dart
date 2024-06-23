import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/nutrition_repository.dart';

class ModifyNutritionOrderUsecase {
  final NutritionRepository nutritionRepository;

  ModifyNutritionOrderUsecase({required this.nutritionRepository});

  Future<Either<Failure, ResponseModel<Null>>> call({
    required ModifyNutritionOrderParams modifyNutritionOrderParams,
  }) async {
    return await nutritionRepository.modifyNutritionOrder(
      modifyNutritionOrderParams: modifyNutritionOrderParams,
    );
  }
}
