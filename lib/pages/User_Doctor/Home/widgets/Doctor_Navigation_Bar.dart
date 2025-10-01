import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class DoctorNavigationBar extends StatelessWidget {
  DoctorNavigationBar(
      {required this.selectedIndex, required this.onSelectedItem});
  int selectedIndex;
  Function(int) onSelectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Jomolhari',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          height: 60,
          indicatorColor: Colors.transparent,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            onSelectedItem(index);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.event_available,
                size: selectedIndex == 0 ? 40 : 35,
                color:
                    selectedIndex == 0 ? midnigth_bule : Colors.grey.shade200,
              ),
              label: 'Completed',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.schedule,
                size: selectedIndex == 1 ? 40 : 35,
                color:
                    selectedIndex == 1 ? midnigth_bule : Colors.grey.shade200,
              ),
              label: 'Upcoming',
            ),
          ],
        ),
      ),
    );
  }
}
