//azad added ...
import 'dart:developer';
import 'package:christiandimene/features/test_exam/data/get_text_quiz/api.dart';
import 'package:christiandimene/features/test_exam/model/test_quiz_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/rx_base.dart';

final class GetTestQuizRx extends RxResponseInt<TestQuizResponse> {
  final api = TestQuizApi.instance;

  bool success = false;

  GetTestQuizRx({required super.empty, required super.dataFetcher});

  ValueStream get getData => dataFetcher.stream;

  Future<void> testQuiz(int id) async {
    try {
      TestQuizResponse data = await api.getTestQuiz(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(TestQuizResponse data) async {
    try {
      TestQuizResponse respose = data;
      log(' response: $respose');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log('error.runtimeType: ${error.runtimeType}');
    if (error is DioException) {
      log('DioException: ${error.message}');
      log('Status Code: ${error.response?.statusCode}');
      if (error.response != null) {
        log(error.response!.data["message"]);
      } else {
        log("${error.message}");
      }

      dataFetcher.sink.addError(error);
    } else {
      log("${error}");

      dataFetcher.sink.addError(error);
    }

    return log(error);
  }
}
