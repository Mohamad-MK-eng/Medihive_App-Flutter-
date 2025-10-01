import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/User.dart';

class Authservices {
  Future<ApiResult> logInRequest(
      {required String email, required String password}) async {
    Map<String, dynamic> requestbody = {'email': email, 'password': password};

    try {
      var responsebody =
          await Api().POST(URL: loginUrl, body: requestbody, token: null);

      if (responsebody['requires_verification']) {
        return ApiResult.failure(
            "check your emails for the given one to verify you'r email");
      } else {
        return ApiResult.success(User.fromJson(responsebody));
      }
    } on Exception catch (e) {
      return ApiResult.failure(e.toString().substring(10));
    }
  }

  Future<ApiResult> signUpRequest(
      {required String email,
      required String password,
      required String firstname,
      required String lastname}) async {
    Map<String, dynamic> requestbody = {
      'email': email,
      'password': password,
      'first_name': firstname,
      'last_name': lastname
    };
    try {
      var responsebody =
          await Api().POST(URL: registerUrl, body: requestbody, token: null);
      if (responsebody['requires_verification']) {
        return ApiResult.success(false);
      } else {
        return ApiResult.success(User.fromJson(responsebody));
      }
    } catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  logoutRequest({required String accessToken}) async {
    try {
      await Api().POST(URL: logoutUrl, body: {}, token: accessToken);
      return true;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  chnagePasswordService(
      {required String token,
      required String oldPass,
      required String newPass}) async {
    Map<String, String> reqBody = {
      "current_password": oldPass,
      "new_password": newPass
    };
    try {
      await Api().POST(URL: change_passwordUrl, body: reqBody, token: token);
      return true;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  Future<ApiResult> sendResetCodeService({required String email}) async {
    try {
      var resonseBody = await Api()
          .POST(URL: forget_password, body: {"email": email}, token: null);
      return ApiResult.success(resonseBody['message']);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }

  Future<ApiResult> resetPasswordService(
      {required Map<String, String> body}) async {
    try {
      var resonseBody =
          await Api().POST(URL: reset_pass_url, body: body, token: null);
      return ApiResult.success(resonseBody['message']);
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
