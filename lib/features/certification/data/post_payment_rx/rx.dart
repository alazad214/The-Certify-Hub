import 'dart:developer';

import 'package:christiandimene/features/certification/data/post_payment_rx/api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';

final class PaymentRx extends RxResponseInt {
  PaymentRx({required super.empty, required super.dataFetcher});
  final api = PostPaymentApi.instance;

  ValueStream get getFileData => dataFetcher.stream;

  Future<Map> paymentData({
    required Map<String, dynamic> courseId,
  }) async {
    try {
      Map data = await api.paymentData(body: courseId);
      log('payment intent data : $data');
      handleSuccessWithReturn(data);
      return data;
      // return handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }
}
