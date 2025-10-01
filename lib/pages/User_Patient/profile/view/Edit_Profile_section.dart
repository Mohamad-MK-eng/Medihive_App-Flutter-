import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/Patient_Profile.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/profile/widgets/DropDownMenue.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class EditProfileSection extends StatefulWidget {
  EditProfileSection({required this.selectedHeader});
  int selectedHeader;

  @override
  State<EditProfileSection> createState() => _EditProfileSectionState();
}

class _EditProfileSectionState extends State<EditProfileSection> {
  String? selectedItem;
  GlobalKey<FormState> formStateKey = GlobalKey();
  // informaion Variables
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? adress;
  DateTime? birthDate;
  String? hintDate;
  String? gender;
  String? bloodType;
  String? conditions;

  @override
  Widget build(BuildContext context) {
    // when changes Applied
    if (context.read<ProfileCubit>().pat_Profile == null) {
      context.read<ProfileCubit>().loadPatProfileInfo(context);
    }

    return widget.selectedHeader == 1
        ? BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Loadingindecator();
            } else if (state is ProfileFailed) {
              return Center(
                child: Text('${state.errorMessage}'),
              );
            } else if (context.read<ProfileCubit>().pat_Profile != null ||
                state is ProfileSuccess) {
              final profile = context.read<ProfileCubit>().pat_Profile;
              return Form(
                key: formStateKey,
                child: ListView(
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomeTextFormField(
                          onChanged: (data) {
                            firstName = data;
                            formStateKey.currentState!.validate();
                          },
                          validator: (value) {
                            return null;
                          },
                          title: 'First Name', // profile.first_name

                          hintText: profile!.first_name,
                          customeWidth: 175,
                        ),
                        CustomeTextFormField(
                          onChanged: (data) {
                            lastName = data;
                            formStateKey.currentState!.validate();
                          },
                          validator: (value) {
                            return null;
                          },
                          title: 'last Name', // profile.last_name

                          customeWidth: 175,
                          hintText: profile.last_name,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomeTextFormField(
                      validator: (value) {
                        return null;
                      },
                      title:
                          'Email', // profile.email (هون بصراحة ما بعرف اذا بده يصير يتغير ام لا لأن اذا مابيتغير في شرط)

                      hintText: profile.email,
                      readOnly: true,
                      customeWidth:
                          350, // شرط readOnly => Profile.email != null
                    ), //
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomeTextFormField(
                          onChanged: (data) {
                            phoneNumber = data;
                            formStateKey.currentState!.validate();
                          },
                          validator: (value) {
                            if (profile.phoneNum == null) {
                              if (phoneNumber == null) {
                                return 'Phone Number required';
                              } else if (phoneNumber != null &&
                                  phoneNumber!.length != 10) {
                                return '10 Digits required';
                              }
                            } else {
                              if ((phoneNumber != null &&
                                      phoneNumber!.isNotEmpty) &&
                                  phoneNumber!.length != 10)
                                return '10 Digits required';
                            }
                            return null;
                          },
                          title: 'Phone Number', // profile.phoneNum

                          customeWidth: 175,
                          isNumber: true,
                          hintText: profile.phoneNum != null
                              ? profile.phoneNum
                              : 'Enter your phone!',
                        ),
                        CustomeTextFormField(
                          validator: (data) {
                            setState(() {});
                            if (profile.birthDate == null) {
                              if (birthDate == null) {
                                return 'Birth Date required';
                              }
                            }
                            return null;
                          },
                          title: 'Birth Date', // profile.BirthDay
                          customeWidth: 175,
                          hintText: profile.birthDate != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(profile.birthDate!))
                              : hintDate != null
                                  ? hintDate
                                  : 'Enter your Birth Date!',
                          // هي منشان ما يطلع الكيبورد
                          readOnly: true,
                          onDateTapped: () async {
                            if (profile.birthDate == null) {
                              final datePicked = await showDatePicker(
                                  context: context,
                                  // intitial Date is used to show the date in data in the first seen of DatePicker
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(DateTime.now().year));
                              if (datePicked != null) {
                                final formattedDate =
                                    DateFormat('dd/MM/yyyy').format(datePicked);
                                birthDate = datePicked;
                                hintDate = formattedDate;

                                formStateKey.currentState!.validate();
                              }
                            } else {
                              showErrorSnackBar(
                                context,
                                'Sorry 🙏, this birth date cannot be edited!',
                              );
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomeTextFormField(
                      onChanged: (data) {
                        adress = data;
                        formStateKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (profile.address == null) {
                          if (adress == null) {
                            return 'Enter your address pricisly';
                          } else if (adress != null && adress!.isEmpty) {
                            return 'Enter your address pricisly';
                          }
                        }
                        return null;
                      },
                      title: 'Adress', // profile.adress

                      hintText: profile.address != null
                          ? profile.address
                          : 'Enter your Adress!',
                      customeWidth: 350,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        buttonText: 'Save Changes',
                        onTap: () async {
                          if (formStateKey.currentState!.validate()) {
                            if (!checkPersonalInfoBeforeSaving(profile)) {
                              showErrorSnackBar(
                                  context, 'No changes detected yet!');
                            } else {
                              showCustomDialog(
                                context: context,
                                type: CustomDialogType.warning,
                                title: 'Confirmation Nedded!',
                                content: profile.birthDate == null
                                    ? "By completing the Operation\n you won't be able to change  your birth date again only"
                                    : 'your informaion will be changed!',
                                onConfirm: () {
                                  updatePersonalProfile(profile);
                                },
                              );
                              // here to put the put request
                            }
                          }
                        },
                        isWideButtons: false,
                        isFontBig: false,
                        enableSaveIcon: true,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          })
        : BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Loadingindecator();
              } else if (state is ProfileFailed) {
                return Center(
                  child: Text('${state.errorMessage}'),
                );
              } else if (context.read<ProfileCubit>().pat_Profile != null ||
                  state is ProfileSuccess) {
                final profile =
                    BlocProvider.of<ProfileCubit>(context).pat_Profile;
                return ListView(
                    shrinkWrap: true,
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDropDowMenu(
                            items: ['Male', 'Female'],
                            title: ' Gender',
                            isEnabled: profile!.medicalInfo!.gender == null,
                            onSelectedItme: (item) {
                              gender = item;
                            },
                            hintText: profile.medicalInfo!.gender,
                          ),
                          CustomDropDowMenu(
                            items: [
                              'A +',
                              'B +',
                              'A -',
                              'B -',
                              'O +',
                              'O -',
                              'AB +',
                              'AB -'
                            ],
                            title: ' Blood Type',
                            isEnabled: profile.medicalInfo!.bloodType == null,
                            onSelectedItme: (item) {
                              bloodType = item;
                            },
                            hintText: profile.medicalInfo!.bloodType,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomeTextFormField(
                        onChanged: (data) {
                          conditions = data;
                        },
                        title: 'Chronic_Conditions',
                        hintText: profile.medicalInfo!.conditions == null
                            ? 'Enter your bad conditions'
                            : profile.medicalInfo!.conditions,
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          buttonText: 'Save Changes',
                          onTap: () async {
                            if (checkMedicalInfoBeforeSaving(
                                profile.medicalInfo!)) {
                              if (shouldUpdateMedicalInfo(
                                  profile.medicalInfo!)) {
                                showCustomDialog(
                                  context: context,
                                  type: CustomDialogType.warning,
                                  title: 'Confirmed required',
                                  content: profile.medicalInfo!.bloodType ==
                                              null &&
                                          profile.medicalInfo!.gender == null
                                      ? "By completing the Operation\n you won't be able to change  your blood type and gender again only"
                                      : 'your informaion will be changed!',
                                  onConfirm: () {
                                    updateMedicalProfile(profile.medicalInfo!);
                                  },
                                );
                              } else {
                                showErrorSnackBar(
                                    context, 'No Changes detected yet!');
                              }
                            } else {
                              showErrorSnackBar(context,
                                  'Blood type and Gender are requierd!');
                            }
                          },
                          isFontBig: false,
                          enableSaveIcon: true,
                        ),
                      )
                    ]);
              } else {
                return const SizedBox();
              }
            },
          );
  }

  bool checkMedicalInfoBeforeSaving(PatientMedicalInfo med) {
    final isBloodTypeSet = med.bloodType != null;
    final isGenderSet = med.gender != null;

    final isBloodTypeValid =
        isBloodTypeSet ? bloodType == null : bloodType != null;
    final isGenderValid = isGenderSet ? gender == null : gender != null;

    return isBloodTypeValid && isGenderValid;
  }

  bool shouldUpdateMedicalInfo(PatientMedicalInfo med) {
    // تحققنا من الدم والجنس
    bool coreDataValid = checkMedicalInfoBeforeSaving(med);

    // المستخدم الجديد: ما عنده bloodType ولا gender → لازم يعبيّن فقط
    final isNewUser = med.bloodType == null && med.gender == null;

    // التحقق من تغيير أو تعبئة الحالات المزمنة
    bool chronicDiseasesChanged = false;

    if (!isNewUser) {
      // فقط إذا المستخدم قديم منتحقق إذا عدل الحالات المزمنة
      chronicDiseasesChanged = (conditions?.trim().isNotEmpty ?? false) &&
          (conditions!.trim() != (med.conditions ?? '').trim());
    }

    return coreDataValid || chronicDiseasesChanged;
  }

  bool checkPersonalInfoBeforeSaving(PatientProfile profile) {
    if ((profile.birthDate != null && birthDate == null) &&
        (firstName == null || firstName!.isEmpty) &&
        (lastName == null || lastName!.isEmpty) &&
        (phoneNumber == null || phoneNumber!.isEmpty) &&
        (adress == null || adress!.isEmpty)) return false;
    return true;
  }

  Map<String, dynamic> getMedicalInfoBody(PatientMedicalInfo med) {
    final Map<String, dynamic> body = {};

    if (bloodType != null && bloodType != med.bloodType) {
      body['blood_type'] = bloodType;
    }

    if (gender != null && gender != med.gender) {
      body['gender'] = gender;
    }

    if (conditions != null && conditions!.trim() != med.conditions?.trim()) {
      body['chronic_conditions'] = conditions!.trim();
    }

    return body;
  }

  updateMedicalProfile(PatientMedicalInfo med) async {
    var body = getMedicalInfoBody(med);

    if (body.isNotEmpty) {
      setState(() {
        conditions = null;
        gender = null;
        bloodType = null;
      });
      await context.read<ProfileCubit>().updatePatProfileInfo(
            context,
            body,
          );
    }
  }

  Map<String, dynamic> getPersonalInfoBody(PatientProfile profile) {
    final Map<String, dynamic> body = {};

    if (firstName != null && firstName!.trim() != profile.first_name.trim()) {
      body['first_name'] = firstName!.trim();
    }

    if (lastName != null && lastName!.trim() != profile.last_name.trim()) {
      body['last_name'] = lastName!.trim();
    }

    if (phoneNumber != null &&
        phoneNumber!.trim() != profile.phoneNum?.trim()) {
      body['phone_number'] = phoneNumber!.trim();
    }

    if (adress != null && adress!.trim() != profile.address?.trim()) {
      body['address'] = adress!.trim();
    }

    // فقط إذا لم يكن موجود سابقاً، ويسمح بإدخاله مرة واحدة فقط
    if (profile.birthDate == null && birthDate != null) {
      body['date_of_birth'] = birthDate!.toIso8601String(); // مناسب للـ API
    }

    return body;
  }

  updatePersonalProfile(PatientProfile profile) async {
    var body = getPersonalInfoBody(profile);

    if (body.isNotEmpty) {
      setState(() {
        firstName = null;
        lastName = null;
        phoneNumber = null;
        birthDate = null;
        adress = null;
      });
      await context.read<ProfileCubit>().updatePatProfileInfo(
            context,
            body,
          );
    }
  }
}
