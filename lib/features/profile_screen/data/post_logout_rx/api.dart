import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class LogOutApi {
  static final LogOutApi _singleton = LogOutApi._internal();
  LogOutApi._internal();
  static LogOutApi get instance => _singleton;
  Future<Map> fetchLogoutData() async {
    try {
      Response response = await postHttp(
        Endpoints.logout(),
      );
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
