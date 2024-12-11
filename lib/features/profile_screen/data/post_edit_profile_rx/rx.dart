import 'dart:developer';
import 'dart:io';
import 'package:christiandimene/features/profile_screen/data/post_edit_profile_rx/api.dart';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../networks/rx_base.dart';

final class PostProfileEditRx extends RxResponseInt {
  final api = PostProfileEditApi.instance;

  PostProfileEditRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> profileData({
    String? email,
    String? name,
    String? phone,
    File? avatar,
  }) async {
    try {
      FormData formData = FormData.fromMap(
        {
          "name": name,
          "phone_number": phone,
          "avatar": avatar != null
              ? await MultipartFile.fromFile(avatar.path,
                  filename: "avatar.jpg")
              : null,
        },
      );

      Map data = await api.profile(formData: formData).waitingForFuture();
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    int? statusCode = data['code'];
    if (statusCode == 200) {
      NavigationService.goBack;
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
