import 'package:flutter/material.dart';
import 'package:medihive_1_/models/Prescription.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/Widgets/Prescription_Card.dart';

class PrescriptionPage extends StatelessWidget {
  PrescriptionPage({required this.dataList});
  List<Prescription> dataList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return PrescriptionCard(
                  presInfo: dataList[index], index: index + 1);
            }),
      ),
    );
  }
}
