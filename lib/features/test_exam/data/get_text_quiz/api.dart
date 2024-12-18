import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';
import '../../model/test_quiz_response.dart';

final class TestQuizApi {
  static final TestQuizApi _singleton = TestQuizApi._internal();
  TestQuizApi._internal();
  static TestQuizApi get instance => _singleton;

  Future<TestQuizResponse> getTestQuiz(int id) async {
    try {
      Response response = await getHttp(Endpoints.testQuiz(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        TestQuizResponse data =
            TestQuizResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
