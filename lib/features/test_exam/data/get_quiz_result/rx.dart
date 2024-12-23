import 'dart:developer';
import 'package:christiandimene/features/test_exam/data/get_quiz_result/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../networks/rx_base.dart';
import '../../model/test_result_response.dart';

final class GetTestQuizResultRx extends RxResponseInt<TestResultResponse> {
  final api = TestQuizResultApi.instance;

  bool success = false;

  GetTestQuizResultRx({required super.empty, required super.dataFetcher});

  ValueStream get getData => dataFetcher.stream;

  Future<void> testQuizResult(int id) async {
    try {
      TestResultResponse data = await api.getTestQuizResult(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(TestResultResponse data) async {
    try {
      TestResultResponse respose = data;
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
