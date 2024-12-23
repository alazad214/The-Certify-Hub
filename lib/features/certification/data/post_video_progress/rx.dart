import 'dart:developer';
import 'package:christiandimene/features/certification/data/post_video_progress/api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';

final class PostProgressRx extends RxResponseInt {
  PostProgressRx({required super.empty, required super.dataFetcher});
  final api = PostVideoProgress.instance;

  ValueStream get getFileData => dataFetcher.stream;

  Future<Map> progressData({
    required Map<String, dynamic> courseId,
  }) async {
    try {
      Map data = await api.progressData(body: courseId);
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
