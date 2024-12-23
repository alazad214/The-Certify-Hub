import 'dart:convert';
import 'dart:developer';
import 'package:christiandimene/features/practice_exam/model/practice_quiz_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

final class PracticeQuizApi {
  static final PracticeQuizApi _singleton = PracticeQuizApi._internal();
  PracticeQuizApi._internal();
  static PracticeQuizApi get instance => _singleton;

  Future<PracticeQuizResponse> getPracticeQuiz(int id) async {
    try {
      Response response = await getHttp(Endpoints.practiceQuiz(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        PracticeQuizResponse data =
            PracticeQuizResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
