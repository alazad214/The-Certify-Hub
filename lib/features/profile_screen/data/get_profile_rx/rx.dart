//azad added ...

import 'dart:developer';
import 'package:christiandimene/features/profile_screen/data/get_profile_rx/api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/get_profile_response.dart';

final class GetProfileDataRx extends RxResponseInt<ProfileResponse> {
  final api = ProfileDetailsApi.instance;

  bool success = false;

  GetProfileDataRx({required super.empty, required super.dataFetcher});

  ValueStream get getProfileCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getprofileData() async {
    try {
      ProfileResponse data = await api.getProfileDetails();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ProfileResponse data) async {
    try {
      ProfileResponse respose = data;
      log('Profile details response: $respose');
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

      dataFetcher.sink.addError(error);
    } else {
      log('Unexpected error: $error');
      message = "An unexpected error occurred. Please try again later.";

      dataFetcher.sink.addError(error);
    }

    return message;
  }
}
