import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class CustomButton extends StatelessWidget {
  final Future<void> Function() onTap;
  final String buttonText;
  final bool isWideButtons;
  final bool isFontBig;
  final bool enableSaveIcon;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isWideButtons = false,
    this.isFontBig = true,
    this.enableSaveIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isWideButtons ? 25 : 16, vertical: 12),
        decoration: BoxDecoration(
          color: mintGreen, // شيل الـ opacity لحتى ما يبين رمادي
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isFontBig ? 20 : 16,
                fontFamily: montserratFont,
                fontWeight: FontWeight.w600,
                color: Colors.black, // أضف لون النص
              ),
            ),
            if (enableSaveIcon)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.save_as, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
