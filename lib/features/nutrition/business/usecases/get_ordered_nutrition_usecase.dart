import 'package:dartz/dartz.dart';
import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/core/params/nutrition_params.dart';
import 'package:medical_examination_app/features/nutrition/business/entities/nutrition_order_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/nutrition_repository.dart';

class GetOrderedNutritionUsecase {
  final NutritionRepository nutritionRepository;

  GetOrderedNutritionUsecase({required this.nutritionRepository});

  Future<Either<Failure, ResponseModel<List<NutritionOrderEntity>>>> call({
    required GetOrderedNutritionParams getOrderedNutritionParams,
  }) async {
    return await nutritionRepository.getOrderedNutritions(
      getOrderedNutritionParams: getOrderedNutritionParams,
    );
  }
}
