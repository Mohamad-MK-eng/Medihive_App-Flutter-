import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Patient_Search/search_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Clinic_Rectangle.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/SearchTextField.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Search_Types_Row.dart';
import 'package:medihive_1_/shared/DoctorContainer.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late FocusNode searchFocusNode;
  int? selectedTypeindex;
  onSelectedType(int index) {
    setState(() {
      selectedTypeindex = index;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode currentnode = FocusScope.of(context);
        if (!currentnode.hasPrimaryFocus) {
          currentnode.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                padding: EdgeInsets.only(right: 27, top: 5, bottom: 5),
                width: Appdimensions.getWidth(325),
                height: Appdimensions.getHight(50),
                child: GestureDetector(
                  onTap: () {
                    if (selectedTypeindex == null)
                      showErrorSnackBar(
                          context, 'Please select a type to search!');
                  },
                  child: SearchTextFormField(
                    isEnabled: selectedTypeindex != null,
                    focusNode: searchFocusNode,
                    searchCont: searchController,
                    hintText: hintText(),
                    selectedItem: selectedTypeindex,
                  ),
                )),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SearchTypesRow(
              selecteTypeIndex: selectedTypeindex,
              onSelectedType: onSelectedType,
            ),
            Divider(
              height: 15,
              color: geryinAuthTextField,
            ),
            Expanded(
                child: selectedTypeindex == 0
                    ? BlocBuilder<PatientSearchCubit, PatientSearchStates>(
                        buildWhen: (previous, current) {
                          return current is PSearchDoctorSuccess ||
                              current is PSearchDoctorFailed;
                        },
                        builder: (context, state) {
                          if (state is PSearchDoctorLoading) {
                            return Loadingindecator();
                          } else if (state is PSearchDoctorFailed) {
                            return Center(
                              child: Text(state.errorMessage!),
                            );
                          } else if (state is PSearchDoctorSuccess) {
                            final doctors =
                                BlocProvider.of<PatientSearchCubit>(context)
                                    .doctors;
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: doctors.length, // topDocctors.length
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      child: Doctorcontainer(
                                          image_path: doctors[index]
                                              .image_path, // doctors[index].image_path
                                          doctor_name: doctors[index]
                                                  .first_name +
                                              ' ' +
                                              doctors[index]
                                                  .last_name, // doctors[index].first_name
                                          doctor_speciality: doctors[index]
                                              .specialty, //doctors[index].last_name
                                          experience_years: doctors[index]
                                              .experience_years, //doctors[index].experience_years
                                          rate: doctors[index]
                                              .rate //doctors[index].rate
                                          ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.doctorDetailsPage,
                                          arguments: doctors[index]);
                                    },
                                  );
                                });
                          } else {
                            return Center();
                          }
                        },
                      )
                    : selectedTypeindex == 1
                        ? BlocBuilder<PatientSearchCubit, PatientSearchStates>(
                            buildWhen: (previous, current) {
                            return current is PSearchClinicSuccess ||
                                current is PSearchClinicFailed;
                          }, builder: (context, state) {
                            if (state is PSearchClinicLoading) {
                              return Loadingindecator();
                            } else if (state is PSearchClinicFailed) {
                              return Center(
                                child: Text(state.errorMessage!),
                              );
                            } else if (state is PSearchClinicSuccess) {
                              final clinics =
                                  BlocProvider.of<PatientSearchCubit>(context)
                                      .clinics;
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 15, top: 0),
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 11,
                                            crossAxisSpacing: 10),
                                    itemCount: clinics.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: ClinicRectangle(
                                            name: clinics[index].name,
                                            imagePath:
                                                clinics[index].imagePath),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.doctorClinicPage,
                                              arguments: {
                                                'clinic_id': clinics[index].id,
                                                'clinic_name':
                                                    clinics[index].name
                                              });
                                        },
                                      );
                                    }),
                              );
                            } else {
                              return Center();
                            }
                          })
                        : Center())
          ],
        ),
      ),
    );
  }

  String hintText() {
    if (selectedTypeindex == null)
      return 'Select a doctor or Clinic first!';
    else if (selectedTypeindex == 0) {
      return 'Search for Doctor!';
    } else {
      return 'Search for Clinic!';
    }
  }
}
