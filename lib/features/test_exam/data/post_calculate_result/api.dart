import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostCalculateQuizApi {
  static final PostCalculateQuizApi _singleton =
      PostCalculateQuizApi._internal();
  PostCalculateQuizApi._internal();
  static PostCalculateQuizApi get instance => _singleton;

  Future<Map> calculateQuiz({required Map<String, dynamic> body}) async {
    try {
      Response response = await postHttp(
        Endpoints.resultCalculate(),
        body,
      );
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
