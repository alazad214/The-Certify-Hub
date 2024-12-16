import 'dart:convert';
import 'dart:developer';
import 'package:christiandimene/features/certification/model/mock_test_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetMockTestApi {
  static final GetMockTestApi _singleton = GetMockTestApi._internal();
  GetMockTestApi._internal();
  static GetMockTestApi get instance => _singleton;

  Future<MockTestResponse> getMockTest(int id) async {
    try {
      Response response = await getHttp(Endpoints.mockTest(id));

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        MockTestResponse data =
            MockTestResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
