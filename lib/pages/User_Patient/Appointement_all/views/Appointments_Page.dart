import 'package:flutter/material.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Absent_Section.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Completed_Section.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Upcoming_Section.dart';
import 'package:medihive_1_/shared/NavigationHeader.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  int selectedHeader = 1;

  onSelectedHeader(int value) {
    setState(() {
      selectedHeader = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Appointments"),
      ),
      body: Column(
        children: [
          NavigationHeader(
            onHeaderTapped: onSelectedHeader,
            selectedBodyHerader: selectedHeader,
            firstHerdaerName: 'Upcoming',
            secondeHeaderName: "Completed",
            thirdHeaderName: "Absent",
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 10,
              thickness: 1,
            ),
          ),
          selectedHeader == 1
              ? Expanded(child: UpcomingSection())
              : selectedHeader == 2
                  ? Expanded(child: CompletedSection())
                  : Expanded(child: AbsentSection())
        ],
      ),
    );
  }
}
