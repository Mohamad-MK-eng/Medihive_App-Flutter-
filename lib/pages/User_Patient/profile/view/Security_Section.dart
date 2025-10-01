import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/Auth/view/Forget_Password_Page.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SecuritySection extends StatefulWidget {
  SecuritySection({required this.selectedHeader});
  int selectedHeader;
  @override
  State<SecuritySection> createState() => _SecuritySectionState();
}

class _SecuritySectionState extends State<SecuritySection> {
  GlobalKey<FormState> fomrpinkey = GlobalKey();
  GlobalKey<FormState> fomrpasskey = GlobalKey();
  String? oldWalletPin;
  String? newWalletPin;
  String? oldPass;
  String? newPass;
  bool isPassLoading = false;
  bool isPInLoading = false;
  @override
  Widget build(BuildContext context) {
    // paswordddddddddddddddddddddddddddddddddddddddddddddddd
    return widget.selectedHeader == 1
        ? ModalProgressHUD(
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
                } else if (state is SendCodeFailed) {
                  setState(() {
                    isPassLoading = false;
                  });
                  showErrorSnackBar(context, state.error);
                } else if (state is SendCodeSuccess) {
                  setState(() {
                    isPassLoading = false;
                  });
                  Future.delayed(Duration(microseconds: 200), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordPage()));
                  });
                }
              },
              child: ModalProgressHUD(
                inAsyncCall: isPassLoading,
                progressIndicator: const Loadingindecator(),
                color: Colors.transparent,
                child: Form(
                  key: fomrpasskey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomeTextFormField(
                          title: 'Old Password',
                          hintText: 'Submit Your old Password!',
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
                        Align(
                          alignment: Alignment(1, 0.0),
                          child: TextButton(
                              onPressed: () {
                                /*   if (emailkey.currentState!.validate()) {
                                  // here to call api
                                  context
                                      .read<AuthCubit>()
                                      .sendResetCode(email: email!);
                                } */
                                final email = context
                                    .read<ProfileCubit>()
                                    .pat_Profile!
                                    .email;
                                if (email != null) {
                                  context
                                      .read<AuthCubit>()
                                      .sendResetCode(email: email);
                                }
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontFamily: jomalhiriFont,
                                  fontSize: 14,
                                  color: lightBlue,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: Appdimensions.getHight(30),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ///// Pinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
        : ModalProgressHUD(
            inAsyncCall: isPInLoading,
            color: Colors.transparent,
            progressIndicator: const Loadingindecator(),
            child: BlocListener<PatWalletCubit, PatWalletState>(
              listenWhen: (previous, current) {
                return current is ChangePinFailed ||
                    current is ChangePinLaoding ||
                    current is ChangePinSuccess;
              },
              listener: (context, state) {
                if (state is ChangePinLaoding) {
                  setState(() {
                    isPInLoading = true;
                  });
                } else if (state is ChangePinFailed) {
                  setState(() {
                    isPInLoading = false;
                  });
                  Future.delayed(Duration(milliseconds: 350), () {
                    showErrorSnackBar(context, '${state.errorMessage}');
                  });
                } else if (state is ChangePinSuccess) {
                  setState(() {
                    isPInLoading = false;
                  });
                  Future.delayed(Duration(milliseconds: 350), () {
                    showCustomDialog(
                        context: context,
                        type: CustomDialogType.success,
                        title: "Success✅",
                        content: "Your Wallet Pin changed Succesfully");
                  });
                }
              },
              child: Form(
                key: fomrpinkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomeTextFormField(
                        title: 'Old Pin',
                        hintText: 'Submit Your old Pin!',
                        isPassword: true,
                        obscuretext: true,
                        isNumber: true,
                        onChanged: (data) {
                          oldWalletPin = data;
                          fomrpinkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Wallet Pin Required!';
                          } else if (value.length != 4) {
                            return '4 Digits Required!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomeTextFormField(
                        title: 'New Pin',
                        hintText: 'Submit Your New Pin!',
                        isPassword: true,
                        obscuretext: true,
                        isNumber: true,
                        onChanged: (data) {
                          newWalletPin = data;
                          fomrpinkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Wallet Pin Required!';
                          } else if (value.length != 4) {
                            return '4 Digits Required!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomeTextFormField(
                        title: '',
                        hintText: 'ReType your New Pin!',
                        isPassword: true,
                        obscuretext: true,
                        isNumber: true,
                        onChanged: (data) {
                          fomrpinkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Pin Confimation required!';
                          } else if (value != newWalletPin) {
                            return "Pin dos'nt mathch!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Appdimensions.getHight(50),
                      ),
                      CustomButton(
                        buttonText: 'Change Pin!',
                        onTap: () async {
                          if (fomrpinkey.currentState!.validate()) {
                            showCustomDialog(
                                context: context,
                                type: CustomDialogType.warning,
                                title: 'Confirmation required!',
                                content:
                                    "You'r about to change your wallet pin!",
                                onConfirm: () {
                                  context
                                      .read<PatWalletCubit>()
                                      .changePinMethod(
                                          context: context,
                                          oldPin: oldWalletPin!,
                                          newPin: newWalletPin!);
                                });
                          }
                        },
                        isFontBig: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
