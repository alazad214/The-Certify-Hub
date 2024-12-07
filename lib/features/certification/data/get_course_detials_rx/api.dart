import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetCourseDetailsApi {
  static final GetCourseDetailsApi _singleton = GetCourseDetailsApi._internal();
  GetCourseDetailsApi._internal();
  static GetCourseDetailsApi get instance => _singleton;

  Future<CourseDetailsResponse> getCourseDetails(Int id) async {
    try {
      Response response = await getHttp(Endpoints.courseDetails(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        CourseDetailsResponse data =
            CourseDetailsResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
