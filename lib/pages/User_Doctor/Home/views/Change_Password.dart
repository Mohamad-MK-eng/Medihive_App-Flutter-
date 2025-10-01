import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> fomrpasskey = GlobalKey();

  String? oldPass;
  String? newPass;
  bool isPassLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentnode = FocusScope.of(context);
        if (!currentnode.hasPrimaryFocus) {
          currentnode.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isPassLoading,
          color: Colors.transparent,
          progressIndicator: const Loadingindecator(),
          child: BlocListener<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              if (state is LoadingAuth) {
                setState(() {
                  isPassLoading = true;
                });
              } else if (state is FailedAuth) {
                setState(() {
                  isPassLoading = false;
                });
                Future.delayed(Duration(milliseconds: 350), () {
                  showErrorSnackBar(context, '${state.error}');
                });
              } else if (state is SuccessAuth) {
                setState(() {
                  isPassLoading = false;
                });
                Future.delayed(Duration(milliseconds: 350), () {
                  showCustomDialog(
                      context: context,
                      type: CustomDialogType.success,
                      title: "Success✅",
                      content: "Your passwrod changed Succesfully");
                });
              }
            },
            child: ModalProgressHUD(
              inAsyncCall: isPassLoading,
              progressIndicator: const Loadingindecator(),
              color: Colors.transparent,
              child: Form(
                key: fomrpasskey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    children: [
                      /*  SizedBox(
                        height: Appdimensions.getHight(50),
                      ), */
                      CustomeTextFormField(
                        title: 'Old Password',
                        hintText: 'Submit Your old Password!',
                        strok_color: midnigth_bule,
                        title_color: hardmintGreen,
                        isPassword: true,
                        obscuretext: true,
                        onChanged: (data) {
                          oldPass = data;
                          fomrpasskey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Old Password Required!';
                          } else if (value.length < 8) {
                            return 'At least 8 characters required!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomeTextFormField(
                        title: 'New Pin',
                        hintText: 'Submit Your New Password!',
                        strok_color: midnigth_bule,
                        title_color: hardmintGreen,
                        isPassword: true,
                        obscuretext: true,
                        onChanged: (data) {
                          newPass = data;
                          fomrpasskey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'New Password Required!';
                          } else if (value.length < 8) {
                            return 'At least 8 characters required!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomeTextFormField(
                        title: '',
                        hintText: 'ReType your New Password!',
                        strok_color: midnigth_bule,
                        title_color: hardmintGreen,
                        isPassword: true,
                        obscuretext: true,
                        onChanged: (data) {
                          fomrpasskey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Password Confimation required!';
                          } else if (value != newPass) {
                            return "Password dos'nt mathch!";
                          }
                          return null;
                        },
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          buttonText: 'Change Password!',
                          onTap: () async {
                            if (fomrpasskey.currentState!.validate()) {
                              showCustomDialog(
                                  context: context,
                                  type: CustomDialogType.warning,
                                  title: 'Confirmation required!',
                                  content:
                                      "You'r about to change your password!",
                                  onConfirm: () {
                                    context
                                        .read<AuthCubit>()
                                        .changePasswordMethod(
                                            context: context,
                                            oldPass: oldPass!,
                                            newPass: newPass!);
                                  });
                            }
                          },
                          isFontBig: false,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
