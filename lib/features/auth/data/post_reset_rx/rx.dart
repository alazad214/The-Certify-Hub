import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:christiandimene/loading_screen.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class ResetPasswordRx extends RxResponseInt {
  final api = ResetPasswordApi.instance;

  ResetPasswordRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;
  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    try {
      Map data = await api
          .resetPassword(
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
            otp: otp,
          )
          .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    await appData.erase();
    if (data["code"] == 200) {
   
    } else {}

    if (data["success"] == false) {
      throw Exception();
    }
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
