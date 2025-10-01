import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomDrawer2 extends StatefulWidget {
  const CustomDrawer2({super.key});

  @override
  State<CustomDrawer2> createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  bool isLoading = false;
  bool _isSwitchingStatus = false;

  // onLogout
  @override
  Widget build(BuildContext context) {
    final profile_cubit = context.read<ProfileCubit>();
    if (profile_cubit.doc_profile == null) {
      profile_cubit.loadDocProfileInfo(context);
    }
    return Drawer(
      surfaceTintColor: light_suger_white,
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.transparent,
        progressIndicator: const CircularProgressIndicator(
          color: lightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) {
              return current is ActivityFialed ||
                  current is Activityloading ||
                  current is ActivitySuccess;
            },
            listener: (context, state) {
              if (state is Activityloading) {
                setState(() {
                  _isSwitchingStatus = true;
                });
              } else if (state is ActivityFialed) {
                setState(() {
                  _isSwitchingStatus = false;
                });
                showOverlaySnackBar(context, state.error);
              } else if (state is ActivitySuccess) {
                setState(() {
                  _isSwitchingStatus = false;
                });
              }
            },
            buildWhen: (previous, current) {
              return ModalRoute.of(context)?.isCurrent == true;
            },
            builder: (context, state) {
              if (state is ProfileLoading) {
                return SizedBox(
                    height: double.infinity,
                    child: Center(child: const Loadingindecator()));
              } else if (state is ProfileFailed) {
                return Center(
                  child: Text('${state.errorMessage}'),
                );
              } else if (state is ProfileSuccess ||
                  profile_cubit.doc_profile != null) {
                final profile = profile_cubit.doc_profile;
                final _is_acitve = profile_cubit.isDoctorActive;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Appdimensions.getHight(60),
                      ),
                      ProfileImageContainer(
                        Image_path: profile_cubit.doc_picture,
                        width: 150,
                        hieght: 150,
                        strok_color: midnigth_bule,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
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
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Activity Status',
                          style: TextStyle(fontSize: 12, color: hardGrey),
                        ),
                      ),
                      SwitchListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.white,
                        activeTrackColor: midnigth_bule,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade300,
                        value: _is_acitve,
                        onChanged: (value) {
                          showCustomDialog(
                            context: context,
                            type: CustomDialogType.warning,
                            title: 'Confirmation required!',
                            content: _is_acitve
                                ? "By DisActivaiting your account you won't be able to recieve any appointments until you activate it again!"
                                : 'By Activaiting your account you will be able to recieve appointments again',
                            onConfirm: () {
                              profile_cubit.switchActivityStatus(
                                  context: context);
                            },
                          );
                        },
                        contentPadding: EdgeInsets.all(0),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: !_isSwitchingStatus
                              ? Text(
                                  _is_acitve ? 'Active' : 'InActive',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: _is_acitve
                                        ? hardmintGreen
                                        : Colors.redAccent.shade200,
                                  ),
                                )
                              : Loadingindecator(),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 2,
                        color: geryinAuthTextField,
                      ),
                      SizedBox(
                        height: Appdimensions.screenHieght *
                            (30) /
                            Appdimensions.vPhoneHight,
                      ),
                      // profile profile profile profile
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.doctor_ProfilePage);
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: midnigth_bule,
                              size: 35,
                            ),
                            const Text(
                              '   Profile',
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
                      // My Patients My patients My patients
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.doctor_patients_page);
                        },
                        child: const Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            FaIcon(
                              FontAwesomeIcons.fileMedical,
                              color: midnigth_bule,
                              size: 25,
                            ),
                            const Text(
                              '   My Patients',
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
                      // notification   notification  notification  notification
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_on_rounded,
                              color: midnigth_bule,
                              size: 35,
                            ),
                            const Text(
                              '   Notifications',
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
                      // change pass change pass change pass change pass
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.doctor_ChangePassword);
                        },
                        child: const Row(
                          children: [
                            const Icon(
                              Icons.key_outlined,
                              color: midnigth_bule,
                              size: 35,
                            ),
                            const Text(
                              '   Change Password',
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
                      ////////// logout logout logout logout
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
                          listenWhen: (previous, current) {
                            // هاد حل ممتاز لتخلي ما تسمع اذا ماكانت بالصفحة
                            return ModalRoute.of(context)?.isCurrent == true;
                          },
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
                                color: midnigth_bule,
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
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
