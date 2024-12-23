import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

import '../../model/test_result_response.dart';

final class TestQuizResultApi {
  static final TestQuizResultApi _singleton = TestQuizResultApi._internal();
  TestQuizResultApi._internal();
  static TestQuizResultApi get instance => _singleton;

  Future<TestResultResponse> getTestQuizResult(int id) async {
    try {
      Response response = await getHttp(Endpoints.testQuizResult(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        TestResultResponse data =
            TestResultResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
