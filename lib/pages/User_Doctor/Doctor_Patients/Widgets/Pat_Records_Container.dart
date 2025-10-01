import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/Pat_Record.dart';

class PatRecordsContainer extends StatelessWidget {
  PatRecordsContainer({required this.record, required this.patinet_name});
  PatRecord record;
  String patinet_name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.patSelectedRecordPage, arguments: {
          'appointment_id': record.report_id,
          "patient_name": patinet_name,
          "type": 'report',
        });
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: Appdimensions.getHight(90)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: whiteGreen,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: const Color(0xFFA9A9A9) /* Dark-Gray */,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                const TextSpan(
                    text: 'Date:  ',
                    style: TextStyle(fontSize: 13, color: midnigth_bule)),
                TextSpan(
                    text: record.date ?? '', style: TextStyle(fontSize: 16))
              ])),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                  overflow: TextOverflow.visible,
                  maxLines: null,
                  TextSpan(children: [
                    const TextSpan(
                        text: 'Report Title:  ',
                        style: TextStyle(fontSize: 13, color: midnigth_bule)),
                    TextSpan(
                        text: record.report_title ?? '',
                        style: TextStyle(fontSize: 14))
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
