//azad added ...
import 'dart:developer';
import 'package:christiandimene/features/profile_screen/data/get_technical_support/api.dart';
import 'package:christiandimene/features/profile_screen/model/technical_support_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';

final class GettechnicalSupportRx
    extends RxResponseInt<TechnicalSupportResponse> {
  final api = TechnicalSupportApi.instance;

  bool success = false;

  GettechnicalSupportRx({required super.empty, required super.dataFetcher});

  ValueStream get technicalData => dataFetcher.stream;

  String message = "";

  Future<void> gettechnicalData() async {
    try {
      TechnicalSupportResponse data = await api.getTechnicalData();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(TechnicalSupportResponse data) async {
    try {
      TechnicalSupportResponse respose = data;
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
