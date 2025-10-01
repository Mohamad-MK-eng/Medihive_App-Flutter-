import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Doctor_Patient.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';

class PatientContainer extends StatelessWidget {
  PatientContainer({required this.data});
  DoctorPatient data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.patient_records_page, arguments: {
          "patient_id": data.patinet_id,
          "patient_name": data.full_name,
        });
      },
      child: Container(
        width: double.infinity,
        height: Appdimensions.getHight(85),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Row(
            children: [
              ProfileImageContainer(
                Image_path: data.patient_image,
                width: 70,
                hieght: 70,
                strok_color: Colors.grey.shade100,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.full_name,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text.rich(
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Phone : ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: data.phone_number ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'last visit at : ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: data.last_visit_date,
                            style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.patient_info_page,
                            arguments: data.patinet_id);
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: hardmintGreen,
                        size: 35,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
