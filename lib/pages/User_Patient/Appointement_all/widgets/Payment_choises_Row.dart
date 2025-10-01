import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class PaymentChoisesRow extends StatelessWidget {
  PaymentChoisesRow(
      {required this.selectedPayMethod, required this.onSelectedOne});
  int? selectedPayMethod;
  Function(int) onSelectedOne;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            onSelectedOne(0);
          },
          child: Center(
            child: Container(
                width: Appdimensions.getWidth(145),
                height: Appdimensions.getHight(50),
                decoration: ShapeDecoration(
                    color: selectedPayMethod == 0
                        ? mintGreen
                        : Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Center(
                    child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Cash Payment',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ))),
          ),
        ),
        GestureDetector(
          onTap: () {
            onSelectedOne(1);
          },
          child: Center(
            child: Container(
                width: Appdimensions.getWidth(145),
                height: Appdimensions.getHight(50),
                decoration: ShapeDecoration(
                    color: selectedPayMethod == 1
                        ? mintGreen
                        : Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Center(
                    child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Wallet Payment',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ))),
          ),
        ),
      ],
    );
  }
}
