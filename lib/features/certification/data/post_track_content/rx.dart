import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostTrackContentRx extends RxResponseInt {
  final api = PostTrackProgress.instance;

  PostTrackContentRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postTrackContent({
    required int userId,
    required int courseModuleId,
    required int courseContentId,
    required bool isCompleted,
  }) async {
    try {
      Map data = await api.trackContent(
          userId: userId,
          courseModuleId: courseModuleId,
          courseContentId: courseContentId,
          isCompleted: isCompleted);

      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
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
