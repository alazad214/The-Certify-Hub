//azad added ...
import 'dart:developer';
import 'package:christiandimene/features/practice_exam/data/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/rx_base.dart';
import '../model/practice_quiz_response.dart';

final class GetPracticeQuizRx extends RxResponseInt<PracticeQuizResponse> {
  final api = PracticeQuizApi.instance;
  bool success = false;
  GetPracticeQuizRx({required super.empty, required super.dataFetcher});
  ValueStream get getData => dataFetcher.stream;
  Future<void> practiceQuiz(int id) async {
    try {
      PracticeQuizResponse data = await api.getPracticeQuiz(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(PracticeQuizResponse data) async {
    try {
      PracticeQuizResponse respose = data;
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
