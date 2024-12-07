import 'dart:developer';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostLogoutRx extends RxResponseInt {
  final api = LogOutApi.instance;

  PostLogoutRx({required super.empty, required super.dataFetcher});

  ValueStream get getLogOutData => dataFetcher.stream;

  Future<void> logogoutF() async {
    try {
      Map data = await api.fetchLogoutData().waitingForFuture();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  void handleSuccessWithReturn(data) async {}

  //ERROR OVVERRIDE..
  @override
  handleErrorWithReturn(error) {
    log('error $error');
    if (error is DioException) {
      log('statuscode ${error.response!.statusCode!}');

      if (error.response!.statusCode == 401) {
        NavigationService.navigateToUntilReplacement(Routes.logInScreen);
      }
    }
    dataFetcher.sink.addError(error);
    return false;
  }
}
