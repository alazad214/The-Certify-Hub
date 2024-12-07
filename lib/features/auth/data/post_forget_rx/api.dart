import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class PostForgetPasswordApi {
  static final PostForgetPasswordApi _singleton =
      PostForgetPasswordApi._internal();
  PostForgetPasswordApi._internal();
  static PostForgetPasswordApi get instance => _singleton;
  Future<Map> forgetpassword({
    required String email,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "email": email,
      };
      Response response = await postHttp(Endpoints.forget(), data);
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
