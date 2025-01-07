import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:christiandimene/features/certification/model/track_content_response.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetTrackContentApi {
  static final GetTrackContentApi _singleton = GetTrackContentApi._internal();
  GetTrackContentApi._internal();
  static GetTrackContentApi get instance => _singleton;

  Future<TrackContentResponse> getmoduleTrack(
      int userId, int courseModuleId) async {
    try {
      Map<String, dynamic> requestBody = {
        "user_id": userId,
        "course_module_id": courseModuleId,
      };

      Response response = await postHttp(
        Endpoints.trackContentProgress(),
        json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        TrackContentResponse data =
            TrackContentResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
