import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import 'api.dart';

final class PostForgetPasswordRx extends RxResponseInt {
  final api = PostForgetPasswordApi.instance;

  PostForgetPasswordRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postForgetPassword({
    required String email,
  }) async {
    try {
      Map data = await api
          .forgetpassword(
            email: email,
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
    String? message = data['message'];
    if (statusCode == 200) {
      NavigationService.navigateTo(Routes.otpVerification);
    } else {
      log(message.toString());
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

      // CustomToastMessage('Error', message);
    }
    return false;
  }
}
