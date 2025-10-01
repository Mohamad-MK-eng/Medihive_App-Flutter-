import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';

class CompletedAppCard extends StatelessWidget {
  CompletedAppCard({
    required this.appointment,
  });
  Doctorappointment appointment;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: whiteGreen.withOpacity(0.94),
      elevation: 2,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Patient Image with optional checkbox
              InkWell(
                onTap: () {
                  // TODO: navigate to patient profile
                  Navigator.pushNamed(context, Routes.patient_info_page,
                      arguments: appointment.patientId);
                },
                child: ProfileImageContainer(
                  Image_path: appointment.imageUrl,
                  width: 70,
                  hieght: 70,
                ),
              ),
              const SizedBox(width: 12),

              // Patient Info and Actions
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    appointment.patientName,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.phone ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF03B1A2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Action Buttons
                ],
              ),
              const Expanded(child: SizedBox()),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    icon: Icons.folder_shared_rounded,
                    label: "Records",
                    color: const Color(0xFF0F9CD0),
                    onTap: () {
                      // TODO: navigate to medical records
                      // هون صفا شغلة تزبيط صفحة السجل
                      Navigator.pushNamed(context, Routes.patient_records_page,
                          arguments: {
                            'patient_id': appointment.patientId,
                            'patient_name': appointment.patientName
                          });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildActionButton(
                      icon: Icons.checklist_outlined,
                      label: 'View',
                      color: midnigth_bule,
                      onTap: () {
                        // here to go to the prescription
                        Navigator.pushNamed(
                            context, Routes.patSelectedRecordPage,
                            arguments: {
                              "appointment_id": appointment.appointmentId,
                              'patient_name': appointment.patientName,
                              "type": "appointment",
                            });
                      }),
                ],
              )
            ],
          )),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                //    color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
