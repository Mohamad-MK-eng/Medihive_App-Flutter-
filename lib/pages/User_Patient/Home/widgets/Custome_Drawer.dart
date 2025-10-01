import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomeDrawer extends StatefulWidget {
  CustomeDrawer({super.key});

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  bool isLoading = false;
  // onLogout
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: lightBlue,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  height: Appdimensions.getHight(80),
                ),
                ProfileImageContainer(
                  Image_path:
                      BlocProvider.of<ProfileCubit>(context).pat_picture,
                  width: 150,
                  hieght: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Loadingindecator();
                    } else if (state is ProfileFailed) {
                      return Center(
                        child: Text('${state.errorMessage}'),
                      );
                    } else if (state is ProfileSuccess ||
                        BlocProvider.of<ProfileCubit>(context).pat_Profile !=
                            null) {
                      final profile =
                          BlocProvider.of<ProfileCubit>(context).pat_Profile;
                      return Text(
                        (profile?.first_name != null &&
                                profile?.last_name != null)
                            ? "${profile!.first_name + ' ' + profile.last_name}"
                            : '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                    height: Appdimensions.screenHieght *
                        (65) /
                        Appdimensions.vPhoneHight),
                Divider(
                  height: 2,
                  color: geryinAuthTextField,
                ),
                // here was the prescriptions
                /*     SizedBox(height: Appdimensions.getHight(40)),
                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.vaccines,
                        color: hardmintGreen,
                        size: 35,
                      ),
                      const Text(
                        '   Your Prescriptions',
                        style: TextStyle(
                          color: const Color(0xFF807C7C),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      )
                    ],
                  ),
                ), */
                SizedBox(
                  height: Appdimensions.screenHieght *
                      (30) /
                      Appdimensions.vPhoneHight,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.clinicInfoPage);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: hardmintGreen,
                        size: 35,
                      ),
                      const Text(
                        '   About us',
                        style: TextStyle(
                          color: const Color(0xFF807C7C),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Appdimensions.screenHieght *
                      (30) /
                      Appdimensions.vPhoneHight,
                ),
                InkWell(
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      type: CustomDialogType.warning,
                      title: 'Are you Sure?',
                      content: 'By confirming you will logout',
                      onConfirm: () {
                        BlocProvider.of<AuthCubit>(context)
                            .logoutMethod(context);
                      },
                    );
                  },
                  child: BlocListener<AuthCubit, AuthCubitState>(
                    listener: (context, state) {
                      if (state is LoadingAuth) {
                        setState(() {
                          isLoading = true;
                        });
                      } else if (state is SuccessAuth) {
                        setState(() {
                          isLoading = false;
                        });
                      } else if (state is FailedAuth) {
                        setState(() {
                          isLoading = false;
                        });
                        showOverlaySnackBar(context, state.error);
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: hardmintGreen,
                          size: 35,
                        ),
                        const Text(
                          '   Log out',
                          style: TextStyle(
                            color: const Color(0xFF807C7C),
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
