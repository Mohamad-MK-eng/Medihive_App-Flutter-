import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class SearchTypesRow extends StatelessWidget {
  SearchTypesRow(
      {required this.selecteTypeIndex,
      required this.onSelectedType,
      this.firstHeaderName = 'Doctor'});
  int? selecteTypeIndex;
  String firstHeaderName;
  Function(int) onSelectedType;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.white,
              indicatorShape: Border(),
              labelTextStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 0),
              ),
            ),
            child: NavigationBar(
                indicatorColor: Colors.white,
                backgroundColor: Colors.transparent,
                height: Appdimensions.getHight(35),
                destinations: [
                  GestureDetector(
                    onTap: () {
                      onSelectedType(0);
                    },
                    child: Center(
                      child: Container(
                          width: Appdimensions.getWidth(130),
                          decoration: ShapeDecoration(
                              color: selecteTypeIndex == 0
                                  ? mintGreen.withOpacity(0.7)
                                  : Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Center(
                              child: Text(
                            firstHeaderName,
                            style: const TextStyle(color: Colors.black),
                          ))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onSelectedType(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Center(
                          child: Container(
                              width: Appdimensions.getWidth(130),
                              decoration: ShapeDecoration(
                                  color: selecteTypeIndex == 1
                                      ? mintGreen.withOpacity(0.7)
                                      : Colors.grey.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Center(child: Text('Clinic')))),
                    ),
                  )
                ])));
  }
}
