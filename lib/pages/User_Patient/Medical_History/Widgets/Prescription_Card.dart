import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/models/Prescription.dart';

class PrescriptionCard extends StatelessWidget {
  PrescriptionCard(
      {required this.presInfo, required this.index, this.onDelete});
  List<String> presTitles = const ['Drug', 'Dose', 'Repeat', 'Notes'];
  Prescription presInfo;
  int index;
  Function()? onDelete;
  List<Icon> presIcons = [
    Icon(
      Icons.medication_outlined,
      color: Colors.blue.shade400,
    ),
    Icon(
      Icons.scale_outlined,
      color: Colors.blue.shade400,
    ),
    Icon(
      Icons.access_time,
      color: Colors.blue.shade400,
    ),
    Icon(
      Icons.note_alt_outlined,
      color: Colors.blue.shade400,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.none,
      color: Colors.grey.shade100,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              _rowItem(presIcons[0], presTitles[0],
                  '${presInfo.drug}  ${presInfo.dose ?? ''}'),
              Divider(
                height: 3,
                color: Colors.grey.shade300,
              ),
              _rowItem(presIcons[2], presTitles[2], presInfo.repeate ?? ''),
              Divider(
                height: 3,
                color: Colors.grey.shade300,
              ),
              _rowItem(presIcons[3], presTitles[3], presInfo.notes ?? ''),
            ]),
          ),
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(50),
                  ))),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$index',
                    style: const TextStyle(color: const Color(0xffffffff)),
                  ),
                ),
              ),
            ),
          ),
          if (onDelete != null)
            Positioned(
                right: -15,
                bottom: -10,
                child: IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.redAccent,
                    )))
        ],
      ),
    );
  }

  Widget _rowItem(Icon icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            "$label:  ",
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: hardGrey, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.visible,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
