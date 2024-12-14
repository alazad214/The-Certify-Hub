import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../model/lesson_model_response.dart';

final class GetLessonsApi {
  static final GetLessonsApi _singleton = GetLessonsApi._internal();
  GetLessonsApi._internal();
  static GetLessonsApi get instance => _singleton;

  Future<LessonsModelResponse> getLessonData(int id) async {
    try {
      Response response = await getHttp(Endpoints.lessonsVideo(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        LessonsModelResponse data =
            LessonsModelResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
