import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../../model/pdf_model_response.dart';

final class GetPdfApi {
  static final GetPdfApi _singleton = GetPdfApi._internal();
  GetPdfApi._internal();
  static GetPdfApi get instance => _singleton;

  Future<PdfModelResponse> getPdfData(int id) async {
    try {
      Response response = await getHttp(Endpoints.pdf(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        PdfModelResponse data =
            PdfModelResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
