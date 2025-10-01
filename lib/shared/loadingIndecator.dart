import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class Loadingindecator extends StatelessWidget {
  const Loadingindecator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: lightBlue,
      ),
    );
  }
}
