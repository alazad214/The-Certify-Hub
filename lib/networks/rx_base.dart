import 'dart:developer';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:rxdart/subjects.dart';

abstract class RxResponseInt<T> {
  T empty;
  BehaviorSubject<T> dataFetcher;
  Map? map;
  BehaviorSubject? dataFetcher2;

  RxResponseInt(
      {required this.empty,
      required this.dataFetcher,
      this.map,
      this.dataFetcher2});

  dynamic handleSuccessWithReturn(T data) {
    dataFetcher.sink.add(data);
    return data;
  }

  dynamic handleErrorWithReturn(dynamic error) {
    log(error.toString());
    // DioException responseError = error as DioException;

    if (error.response!.statusCode == 401) {
      NavigationService.navigateToUntilReplacement(Routes.logInScreen);
    }

    dataFetcher.sink.addError(error);
    throw error;
  }

  void clean() {
    dataFetcher.sink.add(empty);
  }

  void dispose() {
    dataFetcher.close();
  }
}
