import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Patient_Search/search_cubit.dart';

class SearchTextFormField extends StatelessWidget {
  SearchTextFormField(
      {required this.isEnabled,
      required this.focusNode,
      required this.searchCont,
      required this.hintText,
      required this.selectedItem});
  FocusNode focusNode;
  bool isEnabled;
  String hintText;
  TextEditingController searchCont;
  int? selectedItem;

  @override
  Widget build(BuildContext context) {
    final thisCubit = context.read<PatientSearchCubit>();
    return TextField(
      controller: searchCont,
      focusNode: focusNode,
      enabled: isEnabled,
      onChanged: (value) {
        final trimmedData = value.trim();

        // البحث فقط إذا كان هناك تغيير حقيقي
        if (trimmedData.length >= 3 || trimmedData.isEmpty) {
          if (selectedItem != null && selectedItem == 0) {
            thisCubit.searchDoctorMethod(context, trimmedData);
          } else if (selectedItem != null && selectedItem == 1) {
            thisCubit.searchClinicMethod(context, trimmedData);
          }
        }
      },
      decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10),
          hintStyle: TextStyle(
              color: geryinAuthTextField,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          prefixIcon: IconButton(
              onPressed: () {
                searchCont.clear();
              },
              icon: Icon(
                Icons.close,
                color: Colors.red.shade300,
              )),
          suffixIcon: IconButton(
              onPressed: () {
                if (searchCont.text.isEmpty) {
                  showErrorSnackBar(context, 'Please fill some content!');
                } else {
                  if (selectedItem != null && selectedItem == 0) {
                    context
                        .read<PatientSearchCubit>()
                        .searchDoctorMethod(context, searchCont.text);
                    focusNode.unfocus();
                  } else if (selectedItem != null && selectedItem == 1) {
                    context
                        .read<PatientSearchCubit>()
                        .searchClinicMethod(context, searchCont.text);
                    focusNode.unfocus();
                  }
                }
              },
              icon: Icon(Icons.search)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hardmintGreen),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: lightBlue, width: 1.5),
          )),
    );
  }
}
