import 'dart:developer';
import 'package:christiandimene/features/profile_screen/data/get_academic_support/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/academic_support_response.dart';

final class GetAcademicSupportRx
    extends RxResponseInt<AcademicSupportResponse> {
  final api = GetAcademicSupport.instance;

  bool success = false;

  GetAcademicSupportRx({required super.empty, required super.dataFetcher});
  ValueStream get academicData => dataFetcher.stream;
  String message = "";

  Future<void> getAcademicData() async {
    try {
      AcademicSupportResponse data = await api.getData();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(AcademicSupportResponse data) async {
    try {
      AcademicSupportResponse respose = data;
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
