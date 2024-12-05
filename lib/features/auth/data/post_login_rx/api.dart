import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class PostLoginApi {
  static final PostLoginApi _singleton = PostLoginApi._internal();
  PostLoginApi._internal();
  static PostLoginApi get instance => _singleton;
  Future<Map> logIn({
    required String email,
    required String password,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "email": email,
        "password": password,
      };
      Response response = await postHttp(Endpoints.logIn(), data);
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
