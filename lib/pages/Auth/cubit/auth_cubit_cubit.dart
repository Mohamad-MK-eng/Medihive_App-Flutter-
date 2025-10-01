import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/User.dart';
import 'package:medihive_1_/pages/Auth/services/AuthServices.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());

  String? _access_token;
  int? role_id;
  void loginMethod(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoadingAuth());
    final result =
        await Authservices().logInRequest(email: email, password: password);
    if (result.isSuccess) {
      if (result.data is User) {
        await SaveAuth(result.data);
        emit(SuccessAuth());

        Future.delayed(Duration(milliseconds: 200), () {
          roleBasedNavigation(context);
        });
        return;
      } else {
        showCustomDialog(
            context: context,
            type: CustomDialogType.warning,
            title: 'Email Verification Required!',
            content:
                'By confirming the operation an verfication email will sent to your submitted account you need to confirm it so you can continue with the application!',
            onConfirm: () => sendResetCode(email: email));
        return;
      }
    } else {
      emit(FailedAuth(result.error ?? 'unknown error'));
    }
  }

  void signUpMethod(
      {required String first_name,
      required String last_name,
      required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoadingAuth());
    final result = await Authservices().signUpRequest(
        email: email,
        password: password,
        firstname: first_name,
        lastname: last_name);

    if (result.data is User) {
      await SaveAuth(result.data);
      emit(SuccessAuth());

      Future.delayed(Duration(milliseconds: 200), () {
        roleBasedNavigation(context);
      });
      return;
    } else {
      emit(FailedAuth(
          'Patient registered successfully , please check your email to verify your account'));
      return;
    }
  }

  void logoutMethod(BuildContext context) async {
    emit(LoadingAuth());
    if (_access_token != null) {
      final response =
          await Authservices().logoutRequest(accessToken: _access_token!);
      // هون بس مرجع انا true اذا في false بحط && response == true
      if (response is bool) {
        await deleteUserAuth(context);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginPage, (context) => false);
        emit(SuccessAuth());
      } else {
        emit(FailedAuth('Failed to logout! Try again'));
      }
    } else {
      emit(FailedAuth('UnAuthorized'));
    }
  }

  void changePasswordMethod(
      {required BuildContext context,
      required String oldPass,
      required String newPass}) async {
    emit(LoadingAuth());
    if (_access_token != null) {
      final response = await Authservices().chnagePasswordService(
          token: _access_token!, oldPass: oldPass, newPass: newPass);

      if (response == true) {
        // هون simple change password ما في تغييير توكن
        emit(SuccessAuth());
      } else {
        emit(FailedAuth('$response'));
      }
    } else {
      emit(FailedAuth('UnAuthorized'));
    }
  }

  Future<void> sendResetCode({required String email}) async {
    try {
      emit(LoadingAuth());
      var reslut = await Authservices().sendResetCodeService(email: email);
      if (reslut.isSuccess) {
        emit(SendCodeSuccess());
        return;
      } else {
        emit(SendCodeFailed(error: reslut.error));
      }
    } on Exception catch (ex) {
      emit(SendCodeFailed(error: ex.toString()));
    }
  }

  Future<void> resetPassword({required Map<String, String> body}) async {
    try {
      emit(LoadingReset());
      var reslut = await Authservices().resetPasswordService(body: body);
      if (reslut.isSuccess) {
        emit(SuccessReset());
        return;
      } else {
        emit(FailedReset(reslut.error));
      }
    } on Exception catch (ex) {
      emit(FailedReset(ex.toString()));
    }
  }

  set access_token(String? token) => _access_token = token;

  String? get access_token => _access_token != null ? _access_token : null;

  // shared preferences
  Future<void> SaveAuth(User result) async {
    // هي اول عملية login
    final pre = await SharedPreferences.getInstance();
    pre.setBool("isAuthorized", true);
    pre.setString("token", '${result.accessToken!}');
    pre.setInt('role_id', result.role_id!);
    access_token = result.accessToken;
    role_id = result.role_id!;
  }

  Future<void> deleteUserAuth(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthorized');
    await prefs.remove('token');
    await prefs.remove('role_id');
    // deleting cupits content
    final profile = context.read<ProfileCubit>();
    profile.doc_picture = null;
    profile.doc_profile = null;
    profile.pat_Profile = null;
    profile.pat_picture = null;
  }

  void navigatetoHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.patientHome, (context) => false);
  }

  // هي للوغ ان
  void roleBasedNavigation(BuildContext context) {
    if (role_id! == 4) {
      // if patient
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.patientHome, (context) => false);
    } else if (role_id! == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.doctor_home_page, (context) => false);
    }
  }
}
