import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class VerifyOTPRX extends RxResponseInt {
  final api = VerifyOTPApi.instance;

  VerifyOTPRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;
  Future<void> verifyOTP({
    required String email,
    required String code,
  }) async {
    try {
      Map data = await api
          .verifyOTP(
            email: email,
            code: code,
          )
          .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    if (data["code"] == 200) {
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
