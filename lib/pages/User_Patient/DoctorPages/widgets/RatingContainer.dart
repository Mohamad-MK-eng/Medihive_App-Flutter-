import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class Ratingcontainer extends StatelessWidget {
  Ratingcontainer({required this.rate});
  double? rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.getWidth(90),
      height: Appdimensions.getHight(120),
      decoration: ShapeDecoration(
          color: lightSky,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            width: Appdimensions.getWidth(40),
            height: Appdimensions.getHight(55),
            decoration: const ShapeDecoration(
                color: const Color(0xFFF1E9A3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)))),
            child: const Icon(
              Icons.star_border,
              size: 26,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            rate != null ? '$rate' : '4.2',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: const Text(
              'Rating',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExperienceContainer extends StatelessWidget {
  ExperienceContainer({required this.exp_years});
  int? exp_years;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.getWidth(90),
      height: Appdimensions.getHight(120),
      decoration: ShapeDecoration(
          color: lightSky,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            width: Appdimensions.getWidth(40),
            height: Appdimensions.getHight(55),
            decoration: const ShapeDecoration(
                color: const Color(0xFFF18989),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)))),
            child: const Icon(
              Icons.workspace_premium_outlined,
              size: 26,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            exp_years != null ? '+$exp_years Yrs' : '+3 Yrs',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: const Text(
              'Experience',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PatientCounterContainer extends StatelessWidget {
  PatientCounterContainer({required this.patient_num});
  int? patient_num;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.getWidth(90),
      height: Appdimensions.getHight(120),
      decoration: ShapeDecoration(
          color: lightSky,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            width: Appdimensions.getWidth(40),
            height: Appdimensions.getHight(55),
            decoration: const ShapeDecoration(
                color: const Color(0xFFA8E6CF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)))),
            child: const Icon(
              Icons.people_alt_rounded,
              size: 26,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            patient_num != null ? '+$patient_num' : '+500',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'Reviews',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
