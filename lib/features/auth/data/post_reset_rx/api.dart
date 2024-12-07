import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class ResetPasswordApi {
  static final ResetPasswordApi _singleton = ResetPasswordApi._internal();
  ResetPasswordApi._internal();
  static ResetPasswordApi get instance => _singleton;

  Future<Map> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    try {
      Map data = {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "otp": otp,
      };

      Response response = await postHttp(Endpoints.resetPassword(), data);

      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
      // ErrorHandler.handle(error).failure;
    }
  }
}
