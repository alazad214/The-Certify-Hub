import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class PostVideoProgress {
  static final PostVideoProgress _singleton = PostVideoProgress._internal();
  PostVideoProgress._internal();
  static PostVideoProgress get instance => _singleton;

  Future<Map> progressData({required Map<String, dynamic> body}) async {
    try {
      Response response = await postHttp(
        Endpoints.courseProgress(),
        body,
      );
      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
