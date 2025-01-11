import 'dart:convert';
import 'dart:developer';
import 'package:christiandimene/features/profile_screen/model/academic_support_response.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class GetAcademicSupport {
  static final GetAcademicSupport _singleton = GetAcademicSupport._internal();
  GetAcademicSupport._internal();
  static GetAcademicSupport get instance => _singleton;

  Future<AcademicSupportResponse> getData() async {
    try {
      Response response = await getHttp(Endpoints.academicLink());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        AcademicSupportResponse data =
            AcademicSupportResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
