import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Clinic/Clinic_cubit.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({
    required this.selectedIndex,
    required this.onSelectedItem,
  });
  int selectedIndex;
  Function(int) onSelectedItem;

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: geryinAuthTextField,
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
          selectedIndex: widget.selectedIndex,
          onDestinationSelected: (index) {
            widget.onSelectedItem(index);
            getSelectedWidget(context, index);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.ballot_outlined,
                size: widget.selectedIndex == 0 ? 40 : 35,
                color: widget.selectedIndex == 0 ? lightBlue : hardmintGreen,
              ),
              label: 'Medical record',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.calendar_month_outlined,
                size: widget.selectedIndex == 1 ? 40 : 35,
                color: widget.selectedIndex == 1 ? lightBlue : hardmintGreen,
              ),
              label: 'Appointment',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: widget.selectedIndex == 2 ? 40 : 35,
                color: widget.selectedIndex == 2 ? lightBlue : hardmintGreen,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                size: widget.selectedIndex == 3 ? 40 : 35,
                color: widget.selectedIndex == 3 ? lightBlue : hardmintGreen,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // هون تابع الأنتقال الخاص ب NavBar
  getSelectedWidget(BuildContext context, index) async {
    switch (index) {
      case 0:
        widget.onSelectedItem(2);
        final clinics = context.read<ClinicCubit>().clinics;

        Navigator.pushNamed(context, Routes.medicalHistoryPage,
            arguments: clinics);
        return;
      case 1:
        widget.onSelectedItem(2);
        Navigator.pushNamed(context, Routes.appointmentsPage);
        return;
      case 3:
        widget.onSelectedItem(2);
        Navigator.pushNamed(
          context,
          Routes.profilePage,
        );
        return;
    }
  }
}
