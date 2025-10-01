import 'package:flutter/material.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';

class EditDocProfileSec extends StatelessWidget {
  const EditDocProfileSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomeTextFormField(title: 'Phone Number'),
        CustomeTextFormField(
          title: 'Address',
          maxLines: 2,
        ),
        CustomeTextFormField(
          title: 'Bio',
          maxLines: 3,
        ),
      ],
    );
  }
}
