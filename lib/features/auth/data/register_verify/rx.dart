import 'dart:developer';
import 'package:christiandimene/features/auth/data/register_verify/api.dart';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/rx_base.dart';

final class RegisterVerifyRx extends RxResponseInt {
  final api = RegisterVerifyApi.instance;

  RegisterVerifyRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;
  Future<void> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = await api
          .verifyOTP(
            email: email,
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
    int statuscode = data['code'];
    // int? statusCode = data['code'];
    String? accessToken = data['data']['token'];
    int id = data['data']['user']['id'];
    appData.write(userId, id);
    log(appData.read(userId).toString());

    if (statuscode == 200) {
      await appData.write(kKeyAccessToken, accessToken);
      await appData.write(kKeyIsLoggedIn, true);

      // TOKEN UPDATE...
      DioSingleton.instance.update(accessToken!);
      dataFetcher.sink.add(data);
    } else {
      log('Something Wrong');
    }

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
