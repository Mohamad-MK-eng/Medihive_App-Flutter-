import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/cubit/doc_patient_cubit_cubit.dart';

class SearchPatTextField extends StatelessWidget {
  SearchPatTextField({required this.focusNode, required this.searchCont});
  FocusNode focusNode;
  TextEditingController searchCont;
  @override
  Widget build(BuildContext context) {
    final thisCubit = context.read<DocPatientCubit>();
    return TextField(
      controller: searchCont,
      focusNode: focusNode,
      onChanged: (data) {
        final trimmedData = data.trim();

        // البحث فقط إذا كان هناك تغيير حقيقي
        if (trimmedData.length >= 3 || trimmedData.isEmpty) {
          thisCubit.searchPatient(context: context, content: trimmedData);
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(fontSize: 10),
        hintStyle: TextStyle(
            color: Colors.black,
            letterSpacing: 1,
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500),
        hintText: 'Search for patient!',
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
              if (searchCont.text.trim().isEmpty) {
                showErrorSnackBar(
                    context, 'Please fill patient name or phone nubmer!');
              } else {
                context.read<DocPatientCubit>().searchPatient(
                    context: context, content: searchCont.text.trim());
                focusNode.unfocus();
              }
            },
            icon: Icon(Icons.search)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
