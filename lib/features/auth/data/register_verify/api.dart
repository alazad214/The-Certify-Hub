import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class RegisterVerifyApi {
  static final RegisterVerifyApi _singleton = RegisterVerifyApi._internal();
  RegisterVerifyApi._internal();
  static RegisterVerifyApi get instance => _singleton;

  Future<Map> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = {
        "email": email,
        "otp": otp,
      };

      Response response = await postHttp(Endpoints.verifyRegisterOtp(), data);

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
