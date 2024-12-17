import 'dart:developer';
import 'package:christiandimene/constants/app_constants.dart';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/di.dart';
import 'api.dart';

final class PostRegisterRx extends RxResponseInt {
  final api = RegisterApi.instance;

  PostRegisterRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    try {
      Map data = await api
          .signUp(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: password,
          )
          .waitingForFuture();
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    int? statusCode = data['code'];
    String? accessToken = data['data']['token'];

    // SAVE USER TOKEN, ID & EMAIL...
    if (statusCode == 200) {
      await appData.write(kKeyAccessToken, accessToken);
      await appData.write(kKeyIsLoggedIn, true);
      // TOKEN UPDATE...
      DioSingleton.instance.update(accessToken!);
    } else if (statusCode == 422) {
      log("The email has already been taken.");
    }

    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';

    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
      log("Error: $message, Code: $message");
    }
    return false;
  }
}
