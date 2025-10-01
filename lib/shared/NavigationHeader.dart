import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class NavigationHeader extends StatelessWidget {
  NavigationHeader(
      {required this.onHeaderTapped,
      required this.selectedBodyHerader,
      required this.firstHerdaerName,
      required this.secondeHeaderName,
      this.thirdHeaderName});

  Function(int) onHeaderTapped;
  int selectedBodyHerader;
  String firstHerdaerName;
  String secondeHeaderName;
  String? thirdHeaderName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getHeader(1, firstHerdaerName),
        _getHeader(2, secondeHeaderName),
        if (thirdHeaderName != null) _getHeader(3, thirdHeaderName!)
      ],
    );
  }

  TextButton _getHeader(int header_number, String header_name) {
    return TextButton(
      onPressed: () {
        onHeaderTapped(header_number);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            header_name,
            style: TextStyle(
              color: selectedBodyHerader == header_number
                  ? Color(0xFF0F0F10)
                  : geryinAuthTextField,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4), // المسافة بين النص والخط
          Container(
            width: 60, // يمكنك تعديله أو جعله ديناميكي إذا أردت
            height: selectedBodyHerader == header_number ? 3 : 1,
            color:
                selectedBodyHerader == header_number ? lightBlue : Colors.black,
          ),
        ],
      ),
    );
  }
}
