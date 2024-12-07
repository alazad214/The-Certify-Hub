import 'dart:convert';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class CourseApi {
  static final CourseApi _singleton = CourseApi._internal();
  CourseApi._internal();
  static CourseApi get instance => _singleton;

  Future<CourseResponse> getCourseData() async {
    try {
      Response response = await getHttp(Endpoints.course());
      if (response.statusCode == 200) {
        CourseResponse data =
            CourseResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
