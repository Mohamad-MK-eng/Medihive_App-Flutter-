import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Cancel_Reason_Dialog.dart';
import 'package:medihive_1_/shared/Profile_image_container.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  UpcomingAppointmentCard(
      {required this.appointment,
      required this.onLongPressed,
      required this.isSelected,
      required this.toggleSelected,
      required this.index,
      this.selectionMode = false});
  int index;
  bool selectionMode;
  bool isSelected;
  void Function(int, int) toggleSelected;
  Doctorappointment appointment;
  Function(bool) onLongPressed;
  Widget build(BuildContext context) {
    final appCubit = context.read<DoctorAppointmentCubit>();
    return GestureDetector(
      onLongPress: () {
        if (!selectionMode) {
          onLongPressed(true);
          toggleSelected(appointment.appointmentId, index);
        }
      },
      onTap: () {
        // إلغاء التحديد
        if (selectionMode) toggleSelected(appointment.appointmentId, index);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        elevation: 2,
        color: !isSelected
            ? Colors.white
            : Colors.grey.shade200, // Colors.grey.shade200,
        child: Stack(
          children: [
            Positioned(
                right: -5,
                top: -5,
                child: !selectionMode
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context, // ← مهم إضافة context
                            builder: (context) => CancelReasonDialog(
                              onConfirm: (reason) {
                                // هنا تنفيذ عملية الإلغاء مع السبب
                                appCubit.cancelAppointmet(
                                    context: context,
                                    reason: reason,
                                    app_ids: [appointment.appointmentId],
                                    data_index: [index]);
                              },
                              onCancel: () {},
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.redAccent.shade200,
                        ),
                      )
                    : Checkbox(
                        value: isSelected,
                        activeColor: midnigth_bule,
                        onChanged: (value) {
                          toggleSelected(appointment.appointmentId, index);
                        },
                        shape: CircleBorder(
                            side: BorderSide(width: 1, color: hardmintGreen)),
                      )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  AbsorbPointer(
                    absorbing: isSelected,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: Icons.folder_shared_rounded,
                          label: "Records",
                          color: const Color(0xFF0F9CD0),
                          onTap: () {
                            // TODO: navigate to medical records
                            // هون صفا شغلة تزبيط صفحة السجل
                            Navigator.pushNamed(
                                context, Routes.patient_records_page,
                                arguments: {
                                  'patient_id': appointment.patientId,
                                  'patient_name': appointment.patientName
                                });
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.note_add,
                          label: "Add",
                          color: const Color(0xFF0F9CD0),
                          onTap: () {
                            // TODO: navigate to add report page
                            Navigator.pushNamed(context, Routes.addReportPage,
                                arguments: {
                                  "cubit": appCubit,
                                  "appointment": appointment,
                                  "index": index
                                });
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.cancel_presentation,
                          label: "Absent",
                          color: Colors.redAccent,
                          onTap: () {
                            // TODO: mark as absent
                            appCubit.markAsAbsent(
                                context: context,
                                appointment_id:
                                    appointment.appointmentId, //.appointmentId,
                                data_index: index,
                                patient_name: appointment.patientName);
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.check_circle,
                          label: "Examined",
                          color: const Color(0xFF03B1A2),
                          onTap: () {
                            // TODO: mark as arrived
                            context
                                .read<DoctorAppointmentCubit>()
                                .markAsCompleted(
                                    context: context,
                                    data: appointment,
                                    index: index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
