import 'dart:developer';
import 'package:christiandimene/features/certification/data/get_pdf_rx/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/pdf_model_response.dart';

final class GetPdfRx extends RxResponseInt<PdfModelResponse> {
  final api = GetPdfApi.instance;

  bool success = false;

  GetPdfRx({required super.empty, required super.dataFetcher});

  ValueStream get getPdfData => dataFetcher.stream;

  String message = "";

  Future<void> getPdfFile(int id) async {
    try {
      PdfModelResponse data = await api.getPdfData(id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(PdfModelResponse data) async {
    try {
      PdfModelResponse respose = data;
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
