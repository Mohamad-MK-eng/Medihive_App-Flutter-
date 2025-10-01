import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/views/Completed_App_Section.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/views/Upcoming_App_Section.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Custom_Drawer_2.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Doctor_Navigation_Bar.dart';

class DocHomePage extends StatefulWidget {
  const DocHomePage({super.key});

  @override
  State<DocHomePage> createState() => _DocHomePageState();
}

class _DocHomePageState extends State<DocHomePage> {
  DateTime _currentDate = DateTime.now();
  int _selectedPage = 1;

  onSlectedPage(int index) {
    setState(() {
      _selectedPage = index;
      _currentDate = DateTime.now();
    });
    context.read<DoctorAppointmentCubit>().loadDoctorAppointment(
        context: context,
        type: _selectedPage == 0 ? 'completed' : 'upcoming',
        date: DateFormat('yyyy-MM-dd').format(_currentDate));
  }

  void _navigateMonth(int offset) {
    setState(() {
      _currentDate = DateTime(
          _currentDate.year, _currentDate.month, _currentDate.day + offset);
    });
    context.read<DoctorAppointmentCubit>().loadDoctorAppointment(
        context: context,
        type: _selectedPage == 0 ? 'completed' : 'upcoming',
        date: DateFormat('yyyy-MM-dd').format(_currentDate));
  }

  /*  toClearIDsSet(Set<int> data) {
    setState(() {
      data.clear();
    });
  } */

  @override
  void initState() {
    // TODO: implement initState
    context.read<DoctorAppointmentCubit>().loadDoctorAppointment(
        context: context,
        type: _selectedPage == 0 ? 'completed' : 'upcoming',
        date: DateFormat('yyyy-MM-dd').format(_currentDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formattedDate = DateFormat('yyyy-MM-dd').format(_currentDate);
    return Scaffold(
        backgroundColor: Color(0xFFFDFCFC),
        appBar: _getAppBar(_formattedDate, context),
        drawer: CustomDrawer2(),
        bottomNavigationBar: DoctorNavigationBar(
            selectedIndex: _selectedPage, onSelectedItem: onSlectedPage),
        body: _selectedPage == 0
            ? CompletedAppSection(
                formattedDate: _formattedDate,
              )
            : UpcomingAppSection(
                formattedDate: _formattedDate,
              ));
  }

  AppBar _getAppBar(String _formattedDate, BuildContext context) {
    return AppBar(
      backgroundColor: midnigth_bule,
      foregroundColor: Colors.white,
      title: Text(
        _formattedDate,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              _navigateMonth(-1);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            )),
        IconButton(
            onPressed: () {
              _navigateMonth(1);
            },
            icon: const Icon(
              Icons.chevron_right,
              size: 40,
            )),
        IconButton(
            onPressed: () async {
              final _datePicked = await showDatePicker(
                context: context,
                initialDate: _currentDate,
                firstDate: DateTime(2025),
                lastDate: DateTime(2026),
              );
              if (_datePicked != null) {
                setState(() {
                  _currentDate = _datePicked;
                });
              }
              _navigateMonth(0);
            },
            icon: const Icon(
              Icons.calendar_month,
              size: 30,
            )),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
