import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/models/Doctor_Profile.dart';
import 'package:medihive_1_/models/Patient_Profile.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Services/Doctor_Patients_Service.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/services/Doc_Profile_service.dart';
import 'package:medihive_1_/pages/User_Patient/profile/Services/Profile_Services.dart';

part 'profile_state.dart';

File? selectedImage;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  PatientProfile? pat_Profile;
  String? pat_picture;
  DoctorProfile? doc_profile;
  String? doc_picture;
  late bool isDoctorActive;

  loadPatProfileInfo(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token != null) {
        var respose =
            await ProfileServices().getProfileMethod(accessToken: access_token);
        if (respose is PatientProfile) {
          pat_Profile = respose;
          pat_picture = respose.profile_picture_url;
          emit(ProfileSuccess());
        } else {
          emit(ProfileFailed(errorMessage: '$respose'));
        }
      } else
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: ex.toString()));
    }
  }

  loadDocProfileInfo(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token != null) {
        var result = await DocProfileService()
            .getProfileMethod(accessToken: access_token);
        if (result.isSuccess) {
          doc_profile = result.data;
          doc_picture = result.data.image_path;
          isDoctorActive = result.data.is_active;
          emit(ProfileSuccess());
          return;
        } else {
          emit(ProfileFailed(errorMessage: result.error));
          return;
        }
      } else
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
      return;
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: ex.toString()));
    }
  }

  Future<void> getPatProForDoctor(
      {required BuildContext context, required int patient_id}) async {
    try {
      final token = BlocProvider.of<AuthCubit>(context).access_token;
      if (token == null) {
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
        return;
      }
      emit(ProfileLoading());
      var result = await DoctorPatientsService()
          .getPatProfileService(token: token, patient_id: patient_id);
      if (result.isSuccess) {
        pat_Profile = result.data;
        emit(ProfileSuccess());
        return;
      } else {
        emit(ProfileFailed(errorMessage: result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: ex.toString()));
    }
  }

  updatePatProfileInfo(
    BuildContext context,
    Map<String, dynamic> body,
  ) async {
    emit(ProfileLoading());
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token != null) {
        var respose = await ProfileServices()
            .updateInformationMethod(accessToken: access_token, body: body);
        if (respose is PatientProfile) {
          pat_Profile = respose;

          emit(ProfileSuccess());
          return;
        } else {
          emit(ProfileFailed(errorMessage: '$respose'));
        }
      } else
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: ex.toString()));
    }
  }

  updateDocProfileInfo(
      {required BuildContext context,
      required Map<String, String> body}) async {
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token == null) {
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
        return;
      }
      emit(ProfileLoading());
      var result = await DocProfileService()
          .updateProfileService(token: access_token, body: body);
      if (result.isSuccess) {
        doc_profile = result.data;
        emit(ProfileSuccess());
        return;
      } else {
        emit(ProfileFailed(errorMessage: result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: ex.toString()));
    }
  }

  Future<void> switchActivityStatus({required BuildContext context}) async {
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token == null) {
        emit(ActivityFialed(error: 'UnAuthorized'));
        return;
      }
      emit(Activityloading());
      var result =
          await DocProfileService().swithcActivityService(token: access_token);
      if (result.isSuccess) {
        doc_profile!.is_active = result.data;
        isDoctorActive = result.data;
        emit(ActivitySuccess());
        return;
      } else {
        emit(ActivityFialed(error: result.error));
        return;
      }
    } on Exception catch (ex) {
      emit(ActivityFialed(error: ex.toString()));
    }
  }

// مشترككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككك
  void updateProfilePicture(
      {required BuildContext context,
      required File imageFile,
      bool isDoctor = false}) async {
    emit(ProfileLoading());
    try {
      final access_token = BlocProvider.of<AuthCubit>(context).access_token;
      if (access_token != null) {
        String? pictureCopy = isDoctor ? doc_picture : pat_picture;
        // هي منشان تتصفر الصورة وتجرع تتحمل
        isDoctor ? doc_picture = null : pat_picture = null;

        final response = await ProfileServices().updateProfileImageMethod(
            token: access_token,
            body: {},
            imageFile: imageFile,
            isDoctor: isDoctor);
        if (response.success) {
          isDoctor
              ? doc_picture = response.message
              : pat_picture = response.message;
          emit(ProfileSuccess());
          return;
        } else {
          !isDoctor ? pat_picture = pictureCopy : doc_picture = pictureCopy;

          emit(ProfileFailed(errorMessage: response.message));
          return;
        }
      } else {
        emit(ProfileFailed(errorMessage: 'UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(ProfileFailed(errorMessage: '${ex.toString()}'));
    }
  }

// مشتركككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككككك
  void showEditOptions({required BuildContext context, bool isDoctor = false}) {
    showModalBottomSheet(
      backgroundColor: whiteGreen,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () async {
              // ألبوم
              ImagePicker picker = ImagePicker();
              XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 400,
                  maxWidth: 400,
                  imageQuality: 90);
              if (image != null) {
                showCustomDialog(
                  context: context,
                  type: CustomDialogType.warning,
                  title: 'Confirmation required!',
                  content:
                      'By Completing this operation your profile picutre will be changed!',
                  onConfirm: () {
                    Navigator.pop(context);
                    updateProfilePicture(
                        context: context,
                        imageFile: File(image.path),
                        isDoctor: isDoctor);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
                //   File imageFile = File(image.path);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.remove_circle),
            title: Text('Remove Photo'),
            onTap: () {
              // حذف
            },
          ),
        ],
      ),
    );
  }
}
