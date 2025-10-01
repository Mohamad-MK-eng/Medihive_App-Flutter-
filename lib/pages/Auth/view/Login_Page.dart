import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/view/Forget_Password_Page.dart';
import 'package:medihive_1_/pages/Auth/widgets/AuthLogo.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> emailkey = GlobalKey();

  bool isloading = false;
  @override
  void dispose() {
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
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) {
            return ModalRoute.of(context)!.isCurrent == true;
          },
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoadingAuth) {
              setState(() {
                isloading = true;
              });
            } else if (state is SuccessAuth) {
              isloading = false;
              setState(() {});
            } else if (state is FailedAuth) {
              setState(() {
                isloading = false;
              });
              showErrorSnackBar(context, state.error);
            } else if (state is SendCodeFailed) {
              setState(() {
                isloading = false;
              });
              showErrorSnackBar(context, state.error);
            } else if (state is SendCodeSuccess) {
              setState(() {
                isloading = false;
              });
              Future.delayed(Duration(microseconds: 200), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage()));
              });
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isloading,
              progressIndicator: CircularProgressIndicator(
                color: lightBlue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: Appdimensions.getHight(45),
                        ),
                        Authlogo(
                          islogin: true,
                        ),
                        Form(
                          key: emailkey,
                          child: CustomeTextFormField(
                            onChanged: (data) {
                              email = data;
                            },
                            validator: (data) {
                              if (email == null || email!.trim().isEmpty) {
                                return 'Email Reqired!';
                              }
                              return null;
                            },
                            hintText: 'Type your Email!',
                            title: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Type your password!',
                          title: 'Password',
                          isPassword: true,
                          obscuretext: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment(1, 0.0),
                          child: TextButton(
                              onPressed: () {
                                if (emailkey.currentState!.validate()) {
                                  // here to call api
                                  context
                                      .read<AuthCubit>()
                                      .sendResetCode(email: email!);
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
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          buttonText: 'LogIn',
                          // here is the trigger
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).loginMethod(
                                  email: email!,
                                  password: password!,
                                  context: context);
                            }
                          },
                          isWideButtons: false,
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Dont't have an accout!   ",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  Navigator.pushNamed(
                                      context, Routes.registerPage);
                                },
                                child: const Text(
                                  "Join us",
                                  style: TextStyle(
                                      color: lightBlue,
                                      decoration: TextDecoration.underline,
                                      fontFamily: jomalhiriFont,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
