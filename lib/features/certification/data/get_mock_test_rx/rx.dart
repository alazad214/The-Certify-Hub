//azad added ...
import 'dart:developer';
import 'package:christiandimene/features/certification/data/get_mock_test_rx/api.dart';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class GetMockTestRx extends RxResponseInt<MockTestResponse> {
  final api = GetMockTestApi.instance;

  bool success = false;

  GetMockTestRx({required super.empty, required super.dataFetcher});

  ValueStream get getMockTestData => dataFetcher.stream;

  String message = "";

  Future<void> getMockTest(int id) async {
    try {
      MockTestResponse data = await api.getMockTest(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(MockTestResponse data) async {
    try {
      MockTestResponse respose = data;
      log('response: $respose');
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
        message = error.response!.data["message"] ?? "An error occurred";
      } else {
        message = error.message ?? "An unknown error occurred";
      }

      dataFetcher.sink.addError(error);
    } else {
      log('Unexpected error: $error');
      message = "An unexpected error occurred. Please try again later.";

      dataFetcher.sink.addError(error);
    }

    return message;
  }
}
