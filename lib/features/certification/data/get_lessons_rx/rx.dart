//azad added ...
import 'dart:developer';
import 'package:christiandimene/features/certification/data/get_lessons_rx/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/lesson_model_response.dart';

final class GetLessonsRx extends RxResponseInt<LessonsModelResponse> {
  final api = GetLessonsApi.instance;

  bool success = false;

  GetLessonsRx({required super.empty, required super.dataFetcher});

  ValueStream get getLessonData => dataFetcher.stream;

  String message = "";

  Future<void> getLessonsData(int id) async {
    try {
      LessonsModelResponse data = await api.getLessonData(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(LessonsModelResponse data) async {
    try {
      LessonsModelResponse respose = data;
      log('Course details response: $respose');
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
