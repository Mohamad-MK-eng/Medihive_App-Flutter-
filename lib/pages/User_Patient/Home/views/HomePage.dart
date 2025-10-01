import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Clinic/Clinic_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/cubit/top_doctors_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/ClinicContainer.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Custome_Drawer.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Navigation_Bar.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Offers_Section.dart';
import 'package:medihive_1_/pages/User_Patient/Home/widgets/Search_Bar.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';
import 'package:medihive_1_/shared/DoctorContainer.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  int _selectedIndex = 2; // Home هي المحددة بالبداية
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = 2;
    setState(() {});
    super.initState();

    //BlocProvider.of<ClinicCubit>(context).loadClinics();
  }

  @override
  void dispose() {
    // TODO: implement activate
    super.dispose();
  }

  onItemselecte(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// عملية الnavigation من اnavBar file
  @override
  Widget build(BuildContext context) {
    // loading logic
    if (BlocProvider.of<ClinicCubit>(context).clinics.isEmpty) {
      BlocProvider.of<ClinicCubit>(context).loadClinics(context);
    }
    // loading top doctor
    if (BlocProvider.of<TopDoctorsCubit>(context).topDoctors.isEmpty) {
      BlocProvider.of<TopDoctorsCubit>(context).loadTopDoctors(context);
    }
    // here to load profile inforamtion
    if (context.read<ProfileCubit>().pat_Profile == null) {
      context.read<ProfileCubit>().loadPatProfileInfo(context);
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomeDrawer(),
      appBar: AppBar(
        title: Image.asset(
          AuthImage,
          width: 50,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // go to notifications
            },
            icon: Badge(
              isLabelVisible: true,
              child: Icon(Icons.notifications_none_outlined, size: 30),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
              child: HomeSearchBar(),
              onTap: () {
                Navigator.pushNamed(context, Routes.patientSearchPage);
              }),
          Text(
            'Exclusive Offers',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Jomolhari',
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ExclusiveOffersSlider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clinics',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Jomolhari',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                  onPressed: () {
                    // All Clinics
                    if (BlocProvider.of<ClinicCubit>(context)
                        .clinics
                        .isNotEmpty)
                      Navigator.pushNamed(context, Routes.clinicsPage,
                          arguments:
                              BlocProvider.of<ClinicCubit>(context).clinics);
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: lightBlue,
                      fontSize: 15,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height:
                Appdimensions.screenHieght * (115) / Appdimensions.vPhoneHight,
            child: BlocBuilder<ClinicCubit, ClinicState>(
              builder: (context, state) {
                if (state is ClinicsSuccess ||
                    BlocProvider.of<ClinicCubit>(context).clinics.isNotEmpty) {
                  final clinics = BlocProvider.of<ClinicCubit>(context).clinics;
                  return ListView.builder(
                      // لح حط اللستة ييلي بقلت الحالة
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.horizontal,
                      itemCount: clinics.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ClinicContainer(
                            name: clinics[index].name,
                            imagePath: clinics[index].imagePath,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.doctorClinicPage, arguments: {
                              'clinic_id': clinics[index].id,
                              'clinic_name': clinics[index].name
                            });
                          },
                        );
                      });
                } else if (state is ClinicsFailed) {
                  return Center(child: Text("${state.errorMessage}"));
                } else {
                  // loading here
                  return const Loadingindecator();
                }
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Doctors',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Jomolhari',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                  onPressed: () {
                    // Show All Top Doctors
                    if (BlocProvider.of<TopDoctorsCubit>(context)
                        .topDoctors
                        .isNotEmpty) {
                      Navigator.pushNamed(context, Routes.topDoctorsPage,
                          arguments: BlocProvider.of<TopDoctorsCubit>(context)
                              .topDoctors);
                    }
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: lightBlue,
                      fontSize: 15,
                    ),
                  ))
            ],
          ),
          Expanded(
            child: BlocBuilder<TopDoctorsCubit, TopDoctorsState>(
              builder: (context, state) {
                if (state is TDoctorsSuccess ||
                    BlocProvider.of<TopDoctorsCubit>(context)
                        .topDoctors
                        .isNotEmpty) {
                  final topDoctors =
                      BlocProvider.of<TopDoctorsCubit>(context).topDoctors;
                  return ListView.builder(
                      itemCount: topDoctors.length,
                      shrinkWrap:
                          true, // منشان ما تاخد كل المساحة المتاحة الها ، فقط على عدد العناصر ، بس بهي الحالة ما بتأثر لأنها جاي اخر الشي
                      // reverse: true,
                      clipBehavior: Clip.antiAlias,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Doctorcontainer(
                              image_path: topDoctors[index]
                                  .image_path, // topDoctors[index].image_path
                              doctor_name: topDoctors[index].first_name +
                                  ' ' +
                                  topDoctors[index]
                                      .last_name, // topDoctors[index].first_name
                              doctor_speciality: topDoctors[index]
                                  .specialty, //topDoctors[index].last_name
                              experience_years: topDoctors[index]
                                  .experience_years, //topDoctors[index].experience_years
                              rate: topDoctors[index].rate,
                              shadowenabled: false, //topDoctors[index].rate
                            ),
                          ),
                          onTap: () {
                            // Navigat to Doctor Details
                            Navigator.pushNamed(
                                context, Routes.doctorDetailsPage,
                                arguments:
                                    topDoctors[index] // topDoctors[index].id
                                );
                          },
                        );
                      });
                } else if (state is TDoctorsFailed) {
                  return Center(
                    child: Text("${state.errorMessage}"),
                  );
                } else {
                  return const Loadingindecator();
                }
              },
            ),
          ),
        ]),
      ),
      bottomNavigationBar: HomeNavBar(
        selectedIndex: _selectedIndex,
        onSelectedItem: onItemselecte,
      ),
    );
  }
}
