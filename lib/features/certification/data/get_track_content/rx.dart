import 'dart:developer';
import 'package:christiandimene/helpers/all_routes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:christiandimene/features/certification/data/get_track_content/api.dart';
import 'package:christiandimene/features/certification/model/track_content_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/rx_base.dart';

final class GetTrackContentRx extends RxResponseInt<TrackContentResponse> {
  final api = GetTrackContentApi.instance;
  bool success = false;
  String message = "";

  GetTrackContentRx({required super.empty, required super.dataFetcher});

  ValueStream get getCourse => dataFetcher.stream;

  Future<void> gettrackContent(int userId, int courseModuleId) async {
    try {
      TrackContentResponse data =
          await api.getmoduleTrack(userId, courseModuleId);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(TrackContentResponse data) async {
    try {
      TrackContentResponse response = data;
      log('response: $response');
      dataFetcher.sink.add(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log('error.runtimeType: ${error.runtimeType}');
    if (error is DioException) {
      log('DioException: ${error.message}');
      log('Status Code: ${error.response?.statusCode}');
      if (error.response != null) {
        message = error.response!.data["message"] ?? "An error occurred";
      } else {
        message = error.message ?? "An unknown error occurred";
      }

      if (error.response!.statusCode == 401) {
        NavigationService.navigateToUntilReplacement(Routes.logInScreen);
      }
      dataFetcher.sink.addError(error);
    } else {
      log('Unexpected error: $error');
      message = "An unexpected error occurred. Please try again later.";
      dataFetcher.sink.addError(error);
    }

    return message;
  }
}
