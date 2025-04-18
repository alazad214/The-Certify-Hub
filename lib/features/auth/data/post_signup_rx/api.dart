import 'dart:convert';
import 'package:dio/dio.dart' as dio;

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class RegisterApi {
  static final RegisterApi _singleton = RegisterApi._internal();
  RegisterApi._internal();
  static RegisterApi get instance => _singleton;
  Future<Map> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    try {
      Map<dynamic, dynamic> data = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };

      dio.Response response = await postHttp(Endpoints.register(), data);

      if (response.statusCode == 200 || response.statusCode == 422) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
