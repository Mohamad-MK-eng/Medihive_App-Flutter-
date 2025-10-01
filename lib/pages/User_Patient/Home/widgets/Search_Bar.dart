import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF6F6F6)),
        child: Center(
          child: TextField(
              enabled: false,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: hardmintGreen,
                ),
                hintText: 'Search for Clinic or Doctor',
                hintStyle: TextStyle(
                  color: hardGrey,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: mintGreen, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: geryinAuthTextField, width: 2)),
              )),
        ),
      ),
    );
  }
}
