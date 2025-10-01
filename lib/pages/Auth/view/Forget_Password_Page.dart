import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String _wallet_pin = '';
  bool isloading = false;

  String email = '';

  String password = '';

  GlobalKey<FormState> key = GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password Reset'),
        ),
        body: BlocConsumer<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) {
            return current is SuccessReset ||
                current is LoadingReset ||
                current is FailedReset;
          },
          listener: (context, state) {
            if (state is LoadingReset) {
              setState(() {
                isloading = true;
              });
            } else if (state is SuccessReset) {
              setState(() {
                isloading = false;
              });
              showCustomDialog(
                context: context,
                type: CustomDialogType.success,
                title: 'Password reset successfully',
                content:
                    'Now you can go to log in page and sing in with your new password!',
                onConfirm: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.loginPage, (context) => false);
                },
              );
            } else if (state is FailedReset) {
              setState(() {
                isloading = false;
              });
              showErrorSnackBar(context, state.error);
            }
          },
          builder: (context, state) => ModalProgressHUD(
            inAsyncCall: isloading,
            progressIndicator: const Loadingindecator(),
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomeTextFormField(
                        onChanged: (data) {
                          email = data;
                        },
                        validator: (value) {
                          if (email.trim().isEmpty) {
                            return 'fill your email!';
                          }
                          return null;
                        },
                        title: 'Email',
                        hintText: 'Type your email correctly!',
                      ),
                      CustomeTextFormField(
                        onChanged: (data) {
                          password = data;
                          key.currentState!.validate();
                        },
                        validator: (value) {
                          if (password.trim().length < 8) {
                            return 'password must be 8 char at least!';
                          }
                          return null;
                        },
                        isPassword: true,
                        title: 'New password',
                        hintText: 'Type your new password',
                      ),
                      CustomeTextFormField(
                        onChanged: (data) {
                          key.currentState!.validate();
                        },
                        validator: (value) {
                          if (value?.trim() != null && value != password) {
                            return 'password dose not match!';
                          }
                          return null;
                        },
                        isPassword: true,
                        title: '',
                        hintText: 'confirm your password',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Submit your verification code!",
                        style: TextStyle(
                          color: hardGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Pinput(
                        length: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wallet Pin required!';
                          } else if (value.length < 4) {
                            return '4 digits required!';
                          } else {
                            _wallet_pin = value;
                          }
                          return null;
                        },
                        defaultPinTheme: PinTheme(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: hardmintGreen),
                                borderRadius: BorderRadius.circular(7.5))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        overflow: TextOverflow.visible,
                        maxLines: null,
                        'An Email was sent to your account containing your verification pin!',
                        style: TextStyle(
                          fontSize: 13,
                          color: hardGrey,
                        ),
                      ),
                      SizedBox(
                        height: Appdimensions.getHight(100),
                      ),
                      CustomButton(
                          buttonText: ' Verify ',
                          onTap: () async {
                            if (key.currentState!.validate()) {
                              context.read<AuthCubit>().resetPassword(body: {
                                'email': email,
                                'code': _wallet_pin,
                                'password': password
                              });
                            }
                          })
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
