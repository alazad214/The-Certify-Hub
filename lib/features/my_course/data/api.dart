import 'dart:convert';
import 'package:christiandimene/features/my_course/model/purchase_course_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class PurchaseCourseApi {
  static final PurchaseCourseApi _singleton = PurchaseCourseApi._internal();
  PurchaseCourseApi._internal();
  static PurchaseCourseApi get instance => _singleton;

  Future<PurchasedCourseResponse> courseData() async {
    try {
      Response response = await getHttp(Endpoints.purchaseCourse());
      if (response.statusCode == 200) {
        PurchasedCourseResponse data =
            PurchasedCourseResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
