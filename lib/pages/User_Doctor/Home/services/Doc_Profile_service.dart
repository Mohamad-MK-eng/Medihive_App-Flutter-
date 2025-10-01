import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Doctor_Profile.dart';

class DocProfileService {
  Future<ApiResult> getProfileMethod({required String accessToken}) async {
    DoctorProfile? profile;
    try {
      final responseBody =
          await Api().GET(URL: getDoctorProfileUrl, token: accessToken);
      profile = DoctorProfile.fromJson(responseBody['personal_information']);

      return ApiResult.success(profile);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> updateProfileService(
      {required String token, required Map<String, String> body}) async {
    try {
      final resposeBody = await Api()
          .PUT(URL: updateDoctorProfileUrl, body: body, token: token);
      return ApiResult.success(
          DoctorProfile.fromJson(resposeBody['personal_information']));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> swithcActivityService({required String token}) async {
    try {
      var resposeBody = await Api().PATCH(URL: updateActivityUrl, token: token);
      return ApiResult.success(resposeBody['is_active']);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
