import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class CustomDataRow extends StatelessWidget {
  CustomDataRow(
      {required this.title1,
      required this.data1,
      required this.title2,
      required this.data2,
      this.titleColor = hardGrey,
      this.isBigFont = true});
  String title1;
  String data1;
  String? title2;
  String? data2;
  Color titleColor;
  bool isBigFont = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        getDataColumn(tilte: title1, data: data1),
        title2 != null && data2 != null
            ? SizedBox(
                width: Appdimensions.getWidth(35),
              )
            : const SizedBox(),
        title2 != null && data2 != null
            ? getDataColumn(tilte: title2!, data: data2!)
            : SizedBox(),
      ]),
    );
  }

  Widget getDataColumn({required String tilte, required String data}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: hardGrey, width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                tilte,
                style: TextStyle(
                  color: titleColor /* Dark-Gray */,
                  fontSize: isBigFont ? 14 : 13,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data,
              maxLines: null,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Colors.black,
                fontSize: isBigFont ? 16 : 14,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
