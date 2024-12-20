import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/navigation_service.dart';
import 'api.dart';

final class PostLoginRx extends RxResponseInt {
  final api = PostLoginApi.instance;

  PostLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> postLogin({
    required String email,
    required String password,
  }) async {
    try {
      Map data = await api
          .logIn(
            email: email,
            password: password,
          )
          .waitingForFuture();

      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    // int? statusCode = data['code'];

    String? accessToken = data['data']['token']['original']['access_token'];

    int? id = await data['data']['user']['id'];

    appData.write(userId, id);
    log(appData.read(userId).toString());

    // SAVE USER TOKEN, ID & EMAIL...
    appData.write(kKeyAccessToken, accessToken);
    appData.write(kKeyIsLoggedIn, true);
    NavigationService.navigateToUntilReplacement(Routes.bottomNavBarScreen);
    // TOKEN UPDATE...
    DioSingleton.instance.update(accessToken!);
    // Adding data to stream
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
