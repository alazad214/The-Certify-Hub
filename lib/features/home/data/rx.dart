import 'dart:developer';
import 'package:christiandimene/features/home/data/api.dart';
import 'package:christiandimene/features/home/model/course_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class GetCourseRx extends RxResponseInt<CourseResponse> {
  final api = CourseApi.instance;

  bool success = false;

  GetCourseRx({required super.empty, required super.dataFetcher});

  ValueStream get getCourse => dataFetcher.stream;

  String message = "";

  Future<void> getCourseData() async {
    try {
      CourseResponse data = await api.getCourseData();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CourseResponse data) async {
    try {
      CourseResponse respose = data;
      log('course response: $respose');
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
