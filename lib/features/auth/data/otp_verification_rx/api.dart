import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';

final class VerifyOTPApi {
  static final VerifyOTPApi _singleton = VerifyOTPApi._internal();
  VerifyOTPApi._internal();
  static VerifyOTPApi get instance => _singleton;

  Future<Map> verifyOTP({
    required String email,
    required String code,
  }) async {
    try {
      Map data = {
        "email": email,
        "otp": code,
      };

      Response response = await postHttp(Endpoints.verifyOtp(), data);

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
