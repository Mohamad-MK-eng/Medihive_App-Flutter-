import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/widgets/AuthLogo.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isloading = false;

  String? email;

  String? password;

  String? first_name;

  String? last_name;

  GlobalKey<FormState> formkey = GlobalKey();

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
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoadingAuth) {
              isloading = true;
              setState(() {});
            } else if (state is SuccessAuth) {
              isloading = false;
              setState(() {});
            } else if (state is FailedAuth) {
              isloading = false;
              setState(() {});
              showErrorSnackBar(context, state.error);
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
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 40,
                        ),
                        Authlogo(
                          islogin: false,
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            first_name = data;
                            formkey.currentState!.validate();
                          },
                          hintText: 'Type your first name!',
                          title: 'First_Name',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            last_name = data;
                            formkey.currentState!.validate();
                          },
                          hintText: 'Type your last name!',
                          title: 'Last_Name',
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            email = data;
                            formkey.currentState!.validate();
                          },
                          hintText: 'Type your Email',
                          title: 'Email',
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            password = data;
                            formkey.currentState!.validate();
                          },
                          hintText: 'Type your Password!',
                          title: 'Password',
                          isPassword: true,
                          obscuretext: true,
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            formkey.currentState!.validate();
                          },
                          hintText: 'Confirm your password!',
                          title: 'Password',
                          isPassword: true,
                          obscuretext: true,
                          validator: (data) {
                            if (data != password) {
                              return 'password not matched';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            buttonText: 'Sign up',
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .signUpMethod(
                                        email: email!,
                                        password: password!,
                                        first_name: first_name!,
                                        last_name: last_name!,
                                        context: context);
                              }
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already had an accout!   ",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "login",
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
