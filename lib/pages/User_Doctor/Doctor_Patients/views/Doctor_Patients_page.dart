import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Widgets/Patient_Container.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/Widgets/Search_Pat_Text_Field.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/cubit/doc_patient_cubit_cubit.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class DoctorPatientsPage extends StatefulWidget {
  DoctorPatientsPage({super.key});

  @override
  State<DoctorPatientsPage> createState() => _DoctorPatientsPageState();
}

class _DoctorPatientsPageState extends State<DoctorPatientsPage> {
  bool _isSearching = false;
  late FocusNode node;
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    node = FocusNode();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isSearching) {
        context.read<DocPatientCubit>().getDoctorPatient(context: context);
      }
    });
    context.read<DocPatientCubit>().getDoctorPatient(context: context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    node.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thisCubit = context.read<DocPatientCubit>();
    return Scaffold(
      backgroundColor: light_suger_white,
      appBar: AppBar(
        backgroundColor: midnigth_bule,
        foregroundColor: Colors.white,
        title: _isSearching
            ? SearchPatTextField(
                searchCont: _searchController,
                focusNode: node,
              )
            : const Text(
                'My Patients',
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      node.unfocus();
                      thisCubit.patSearchData.clear();
                      thisCubit.exitSearchMode();
                      _searchController.clear();
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                      node.requestFocus();
                    });
                  },
                ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<DocPatientCubit, DocPatientState>(
            buildWhen: (previous, current) {
              return current is PatientsLoading ||
                  current is PatientsSuccess ||
                  current is PatientsFailed ||
                  current is PatientsInitial;
            },
            builder: (context, state) {
              if (state is PatientsLoading) {
                return const Loadingindecator();
              } else if (state is PatientsFailed) {
                return Center(
                    child: Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                ));
              } else if (state is PatientsSuccess) {
                final data = _isSearching
                    ? thisCubit.patSearchData
                    : thisCubit.allPatientsData;
                return ListView.builder(
                    itemCount:
                        thisCubit.hasMorePat ? data.length + 1 : data.length,
                    itemBuilder: (context, index) {
                      if (index < data.length)
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 7,
                          ),
                          child: PatientContainer(
                            data: data[index],
                          ),
                        );
                      else if (!_isSearching) {
                        return const SizedBox(
                            height: 50,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: lightBlue,
                            )));
                      } else {
                        return const SizedBox();
                      }
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          )),
    );
  }
}
