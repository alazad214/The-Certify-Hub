import 'dart:developer';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/features/my_course/data/api.dart';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/di.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../home/model/course_response.dart';

final class GetPurchaseCourseRx extends RxResponseInt<CourseResponse> {
  final api = PurchaseCourseApi.instance;

  bool success = false;

  GetPurchaseCourseRx({required super.empty, required super.dataFetcher});

  ValueStream get getCourse => dataFetcher.stream;

  String message = "";

  Future<void> GetCourseData() async {
    try {
      CourseResponse data = await api.courseData();
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

      if (error.response!.statusCode == 401) {
        NavigationService.navigateToUntilReplacement(Routes.logInScreen);
        appData.write(kKeyIsLoggedIn, false);
        appData.write(kKeyIsExploring, false);
        appData.remove(kKeyAccessToken);
        appData.read(userId).toString();
      } else {
        NavigationService.navigateToUntilReplacement(Routes.logInScreen);
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
