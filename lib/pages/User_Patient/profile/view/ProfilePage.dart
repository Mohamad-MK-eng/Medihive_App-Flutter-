import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/profile/view/Edit_Profile_section.dart';
import 'package:medihive_1_/pages/User_Patient/profile/view/Security_Section.dart';
import 'package:medihive_1_/pages/User_Patient/profile/view/Wallet_Info_Section.dart';
import 'package:medihive_1_/pages/User_Patient/profile/widgets/Custome_profile_Container.dart';
import 'package:medihive_1_/shared/NavigationHeader.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class Profilepage extends StatefulWidget {
  Profilepage({this.initialIndex = 0});
  int initialIndex;
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  int selectedTap = 0;
  int selectedBodyIndex = 1;
  bool isWalletActivated = true;
  bool isTranPaginating = false;

  void onContainerTapped(int index) {
    setState(() {
      selectedTap = index;
    });
  }

  void onBodyIndexTapped(int index) {
    setState(() {
      selectedBodyIndex = index;
    });
  }

  @override
  void initState() {
    selectedTap = widget.initialIndex;
    super.initState();
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
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Image.asset(
            AuthImage,
            width: 50,
            height: 50,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: Appdimensions.screenHieght *
                      (30) /
                      Appdimensions.vPhoneHight,
                ),

                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Loadingindecator();
                    } else if (state is ProfileFailed) {
                      return Center(
                        child: Text(state.errorMessage!),
                      );
                    } else
                      return GestureDetector(
                        child: ProfileImageContainer(
                            Image_path:
                                context.read<ProfileCubit>().pat_picture),
                        onTap: () {
                          context
                              .read<ProfileCubit>()
                              .showEditOptions(context: context);
                        },
                      );
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${context.read<ProfileCubit>().pat_Profile?.first_name} ${context.read<ProfileCubit>().pat_Profile?.last_name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Edit Profile , Password Manager , Payment info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onContainerTapped(1);
                      },
                      child: CustomeProfileContainer(
                        selectedIndex: selectedTap,
                        index: 1,
                        onSelectedIndex: onContainerTapped,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onContainerTapped(2);
                      },
                      child: CustomeProfileContainer(
                        index: 2,
                        selectedIndex: selectedTap,
                        onSelectedIndex: onContainerTapped,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onContainerTapped(3);
                      },
                      child: CustomeProfileContainer(
                        index: 3,
                        selectedIndex: selectedTap,
                        onSelectedIndex: onContainerTapped,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 2,
                  color: geryinAuthTextField,
                ),

                selectedTap == 1
                    ? NavigationHeader(
                        selectedBodyHerader: selectedBodyIndex,
                        onHeaderTapped: onBodyIndexTapped,
                        firstHerdaerName: 'Personal info',
                        secondeHeaderName: 'Medical info',
                      )
                    : Center(),
                selectedTap == 1
                    ? Expanded(
                        child: EditProfileSection(
                        selectedHeader: selectedBodyIndex,
                      ))
                    : Center(),
                selectedTap == 2
                    ? NavigationHeader(
                        onHeaderTapped: onBodyIndexTapped,
                        selectedBodyHerader: selectedBodyIndex,
                        firstHerdaerName: 'Password',
                        secondeHeaderName: 'Wallet Pin')
                    : Center(),
                selectedTap == 2
                    ? Expanded(
                        child:
                            SecuritySection(selectedHeader: selectedBodyIndex))
                    : SizedBox(),
                selectedTap == 3
                    ? NavigationHeader(
                        onHeaderTapped: onBodyIndexTapped,
                        selectedBodyHerader: selectedBodyIndex,
                        firstHerdaerName: 'Wallet info',
                        secondeHeaderName: 'Transactions')
                    : Center(),
                selectedTap == 3
                    ? Expanded(
                        child: WalletInfoSection(
                            selectedHeader: selectedBodyIndex))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
