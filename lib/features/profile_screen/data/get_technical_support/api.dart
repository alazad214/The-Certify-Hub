import 'dart:convert';
import 'dart:developer';
import 'package:christiandimene/features/profile_screen/model/technical_support_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class TechnicalSupportApi {
  static final TechnicalSupportApi _singleton = TechnicalSupportApi._internal();
  TechnicalSupportApi._internal();
  static TechnicalSupportApi get instance => _singleton;

  Future<TechnicalSupportResponse> getTechnicalData() async {
    try {
      Response response = await getHttp(Endpoints.technicalLink());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        TechnicalSupportResponse data =
            TechnicalSupportResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
