import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/Doctor_Profile.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/Data_Row.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late GlobalKey<FormState> form_key;
  String? new_phone;
  String? new_address;
  String? new_bio;
  bool inEditMode = false;

  @override
  void initState() {
    // TODO: implement initState
    form_key = GlobalKey();

    super.initState();
  }

  List<Widget> _build_Custom_Data_Row(DoctorProfile data) {
    Map<String, String?> map_info = {
      'First Name': data.first_name,
      'Last Name': data.last_name,
      'Phone Number': data.phone_num,
      'Email': data.email,
      'Address': data.address,
      'Gender': data.gender,
      'Specialty': data.specialty,
      'Clinic': data.clinic_name,
      'Consulting Fee': '${data.fee}',
      'working Days': data.workingDays.join("-"),
      'Start Working date': data.start_working_data,
      'Experience years': data.experience_years?.toString(),
      'Rating': data.rate,
      'Rates count': '${data.reviews_count ?? ''}',
      'Bio': data.bio,
    };

    final rows = <CustomDataRow>[];
    final entries = map_info.entries.toList();
    for (int i = 0; i < entries.length; i += 2) {
      rows.add(CustomDataRow(
        title1: entries[i].key,
        data1: "${entries[i].value ?? ''}",
        title2: i + 1 < entries.length ? "${entries[i + 1].key}" : null,
        data2: i + 1 < entries.length ? "${entries[i + 1].value}" : null,
        isBigFont: false,
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final profile_cubit = context.read<ProfileCubit>();
    if (profile_cubit.doc_profile == null) {
      profile_cubit.loadDocProfileInfo(context);
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode node = FocusScope.of(context);
        if (!node.hasPrimaryFocus) {
          node.unfocus();
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await profile_cubit.loadDocProfileInfo(context);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return SizedBox(
                          height: Appdimensions.screenHieght - 50,
                          child: Loadingindecator());
                    } else if (state is ProfileFailed) {
                      return SizedBox(
                        height: Appdimensions.screenHieght - 50,
                        child: Center(
                          child: Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (state is ProfileSuccess ||
                        profile_cubit.doc_profile != null) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: Appdimensions.getHight(125),
                            decoration: ShapeDecoration(
                                color: midnigth_bule,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.elliptical(350, 75),
                                  bottomRight: Radius.elliptical(350, 75),
                                ))),
                          ),
                          SizedBox(
                            height: (Appdimensions.getHight(125) / 4) + 20,
                          ),
                          Text(
                            'Dr ${profile_cubit.doc_profile?.first_name ?? ''} ${profile_cubit.doc_profile?.last_name ?? ''}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            // here is the Head Rowwwwwwwwwwwwwwwwwww
                            child: Row(
                              children: [
                                inEditMode
                                    ? const Text(
                                        'Close Editing  ',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      )
                                    : const Text(
                                        'Personal Inforamtion',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                inEditMode
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            inEditMode = !inEditMode;
                                            new_address = null;
                                            new_bio = null;
                                            new_phone = null;
                                          });
                                        },
                                        child: FaIcon(
                                          Icons.close_rounded,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const Expanded(child: SizedBox()),
                                InkWell(
                                    onTap: !inEditMode
                                        ? () {
                                            setState(() {
                                              inEditMode = !inEditMode;
                                            });
                                          }
                                        : () {
                                            if (_detectAnyChanges()) {
                                              _updateProfileInfoMethod();
                                            } else {
                                              showErrorSnackBar(context,
                                                  'Sorry! No Changes has detected!');
                                            }
                                          },
                                    child: Icon(
                                      inEditMode ? Icons.save_as : Icons.edit,
                                      color: hardmintGreen,
                                      size: 27,
                                    )),
                                Text(
                                  inEditMode ? '  Save' : '  Edti',
                                  style: TextStyle(
                                    color: const Color(0xFF00BFA6),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          ////// here is the bodyyyyyyyyyyyyyyyyyyyyyyyyy
                          ///// here is the wrapiing with bloc
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: inEditMode
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Form(
                                        key: form_key,
                                        child: CustomeTextFormField(
                                          onChanged: (data) {
                                            new_phone = data;
                                            form_key.currentState!.validate();
                                          },
                                          validator: (value) {
                                            if (value!.trim().isNotEmpty &&
                                                value.length != 10) {
                                              return '10 digits required';
                                            } else {
                                              return null;
                                            }
                                          },
                                          title: 'Phone Number',
                                          hintText:
                                              'Type your new Phone Number!',
                                          isNumber: true,
                                          strok_color: midnigth_bule,
                                          title_color: hardmintGreen,
                                        ),
                                      ),
                                      CustomeTextFormField(
                                        onChanged: (data) {
                                          new_address = data;
                                        },
                                        title: 'Address',
                                        hintText: 'Type your new address!',
                                        maxLines: 2,
                                        strok_color: midnigth_bule,
                                        title_color: hardmintGreen,
                                      ),
                                      CustomeTextFormField(
                                        onChanged: (data) {
                                          new_bio = data;
                                        },
                                        title: 'Bio',
                                        hintText: 'Type a new bio!',
                                        maxLines: 3,
                                        strok_color: midnigth_bule,
                                        title_color: hardmintGreen,
                                      ),
                                    ],
                                  )

                                /// هون الوضع العادي مو التعديللللل
                                : Column(
                                    children: _build_Custom_Data_Row(
                                        profile_cubit.doc_profile!)),
                          )
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

                // also the wraping with bloc
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileSuccess)
                      return Positioned(
                          top: (Appdimensions.getHight(125) / 2) -
                              25, // 75 هو نص ارتفاع الصورة (150)
                          left: (Appdimensions.screenWidth / 2) - 100 / 2,
                          child: Stack(
                            children: [
                              ProfileImageContainer(
                                Image_path: profile_cubit.doc_picture,
                                width: 100,
                                hieght: 150,
                              ),
                              inEditMode
                                  ? Positioned(
                                      bottom: 15,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          // شغل تغيير الصورة
                                          profile_cubit.showEditOptions(
                                              context: context, isDoctor: true);
                                        },
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF00BFA6),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ));
                    else
                      return const SizedBox();
                  },
                ),
                Positioned(
                    left: 7,
                    top: 40,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _detectAnyChanges() {
    return (new_phone != null && new_phone!.trim().isNotEmpty) ||
        (new_address != null && new_address!.trim().isNotEmpty) ||
        (new_bio != null && new_bio!.trim().isNotEmpty);
  }

  _updateProfileInfoMethod() {
    Map<String, String> body = {};
    if (new_phone != null && new_phone!.trim().isNotEmpty) {
      body['phone_number'] = new_phone!;
    }
    if (new_address != null && new_address!.trim().isNotEmpty) {
      body['address'] = new_address!;
    }
    if (new_bio != null && new_bio!.trim().isNotEmpty) {
      body['bio'] = new_bio!;
    }
    context
        .read<ProfileCubit>()
        .updateDocProfileInfo(context: context, body: body);
  }
}
