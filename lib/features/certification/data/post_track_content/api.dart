import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class PostTrackProgress {
  static final PostTrackProgress _singleton = PostTrackProgress._internal();
  PostTrackProgress._internal();
  static PostTrackProgress get instance => _singleton;
  Future<Map> trackContent({
    required int userId,
    required int courseModuleId,
    required int courseContentId,
    required bool isCompleted,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "user_id": userId,
        "course_module_id": courseModuleId,
        "course_content_id": courseContentId,
        "is_completed": isCompleted,
      };
      Response response =
          await postHttp(Endpoints.trackContentProgress(), data);
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
