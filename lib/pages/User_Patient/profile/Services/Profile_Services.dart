import 'dart:io';

import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/Patient_Profile.dart';

class ProfileServices {
  getProfileMethod({required String accessToken}) async {
    PatientProfile? profile;
    try {
      final responseBody =
          await Api().GET(URL: FethcProfileInfoUrl, token: accessToken);
      profile = PatientProfile.fromJson(responseBody);

      return profile;
    } on Exception catch (ex) {
      return ex.toString();
    }
  }

  updateInformationMethod(
      {required String accessToken, required Map<String, dynamic> body}) async {
    PatientProfile? profile;
    try {
      final responseBody = await Api()
          .PUT(URL: updateProfileInfoUrl, body: body, token: accessToken);
      profile = PatientProfile.fromJson(responseBody);
      return profile;
    } on Exception catch (ex) {
      return ex.toString();
    }
  }

  updateProfileImageMethod(
      {required String token,
      required Map<String, dynamic> body,
      required File imageFile,
      bool isDoctor = false}) async {
    try {
      String url;
      !isDoctor
          ? url = updatePatProfileImage
          : url = updateDoctorProfileImageUrl;

      var responseBody = await Api().POST(
          URL: url,
          body: body,
          token: token,
          file: imageFile,
          isMultipart: true,
          fileKey: 'profile_picture');

      return ApiResult(
          success: true, message: responseBody['profile_picture_url']);
    } on Exception catch (ex) {
      return ApiResult(success: false, message: ex.toString());
    }
  }
}

class ApiResult {
  bool success;
  String message;
  ApiResult({required this.success, required this.message});
}
