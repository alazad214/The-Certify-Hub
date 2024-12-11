//azad added ...
import 'dart:developer';

import 'package:christiandimene/features/certification/data/get_course_detials_rx/api.dart';
import 'package:christiandimene/features/certification/model/course_details_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class GetCourseDetailsRx extends RxResponseInt<CourseDetailsResponse> {
  final api = GetCourseDetailsApi.instance;

  bool success = false;

  GetCourseDetailsRx({required super.empty, required super.dataFetcher});

  ValueStream get getCourseDetails => dataFetcher.stream;

  String message = "";

  Future<void> getCourseDetailsdata(int id) async {
    try {
      CourseDetailsResponse data = await api.getCourseDetails(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CourseDetailsResponse data) async {
    try {
      CourseDetailsResponse respose = data;
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
