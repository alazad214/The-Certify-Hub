import 'dart:convert';
import 'dart:developer';
import 'package:christiandimene/features/profile_screen/model/get_profile_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class ProfileDetailsApi {
  static final ProfileDetailsApi _singleton = ProfileDetailsApi._internal();
  ProfileDetailsApi._internal();
  static ProfileDetailsApi get instance => _singleton;

  Future<ProfileResponse> getProfileDetails() async {
    try {
      Response response = await getHttp(Endpoints.profile());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        ProfileResponse data =
            ProfileResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
