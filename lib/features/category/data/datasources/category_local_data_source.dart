import 'dart:convert';

import 'package:medical_examination_app/core/constants/response.dart';
import 'package:medical_examination_app/features/category/data/models/icd_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/template_model.dart';

abstract class CategoryLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();

  Future<void> cacheICD({required ResponseModel<List<ICDModel>>? icdToCache});
  Future<ResponseModel<List<ICDModel>>> getLastICD();
}

const cachedTemplate = 'CACHED_TEMPLATE';
const cachedICD = 'CACHED_ICD';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sharedPreferences.getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(
          TemplateModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedTemplate,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheICD(
      {required ResponseModel<List<ICDModel>>? icdToCache}) async {
    if (icdToCache != null) {
      sharedPreferences.setString(
          cachedICD,
          json.encode(
            icdToCache.toJson(
              toJsonD: (data) => data.map((e) => e.toJson()).toList(),
            ),
          ));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseModel<List<ICDModel>>> getLastICD() async {
    final jsonString = sharedPreferences.getString(cachedICD);

    if (jsonString != null) {
      return Future.value(ResponseModel<List<ICDModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (json) =>
              json.map<ICDModel>((e) => ICDModel.fromJson(json: e)).toList()));
    } else {
      throw CacheException();
    }
  }
}
