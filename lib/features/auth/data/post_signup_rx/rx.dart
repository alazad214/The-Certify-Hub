import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
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

    // SAVE USER TOKEN, ID & EMAIL...

    if (statusCode == 200) {
      NavigationService.navigateToReplacement(Routes.otpVerification);
      Get.snackbar(
        "Success",
        "Verify Otp Send",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (statusCode == 422) {
      log("The email has already been taken.");
      Get.snackbar(
        "Error",
        "The email has already been taken.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
