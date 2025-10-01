import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';
import 'package:medihive_1_/helper/Error_Dialog.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Cancel_Reason_Dialog.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/widgets/Upcomming_App_Card.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class UpcomingAppSection extends StatefulWidget {
  UpcomingAppSection({required this.formattedDate});
  String formattedDate;
  @override
  State<UpcomingAppSection> createState() => _UpcomingAppSectionState();
}

class _UpcomingAppSectionState extends State<UpcomingAppSection> {
  bool _inSelectionMode = false;
  Set<int> _selectedIds = {};
  bool _isRefreshing = false;
  Set<int> _selected_data_indexed = {};
  late ScrollController _scrollController;

  initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<DoctorAppointmentCubit>().paginateDoctorApp(
              context: context,
              type: 'upcoming',
              date: widget.formattedDate,
            );
      }
    });
    super.initState();
  }

  Future<void> _onDragDowntoRefresh() async {
    // here to reorder upcoming appointment
    setState(() {
      _isRefreshing = true;
    });
    await context.read<DoctorAppointmentCubit>().loadDoctorAppointment(
        context: context,
        type: 'upcoming',
        date: widget.formattedDate,
        isRefreshing: true);
    setState(() {
      _isRefreshing = false;
    });
  }

  _triggerSelectionMode(bool value) {
    _selectedIds.clear();
    _selected_data_indexed.clear();
    setState(() {
      _inSelectionMode = value;
    });
  }

  void _toggleSelected(int app_id, int data_index) {
    setState(() {
      if (!_selectedIds.remove(app_id)) {
        _selectedIds.add(app_id);
      }
      if (!_selected_data_indexed.remove(data_index)) {
        _selected_data_indexed.add(data_index);
      }
      if (_selectedIds.isEmpty && _selected_data_indexed.isEmpty) {
        _inSelectionMode = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<DoctorAppointmentCubit>();
    return BlocConsumer<DoctorAppointmentCubit, DoctorAppointmentState>(
      buildWhen: (previous, current) {
        return current is AppointmentFailed ||
            current is AppointmentLoading ||
            current is AppointmentSucess &&
                ModalRoute.of(context)?.isCurrent == true;
      },
      listener: (context, state) {
        // TODO: implement listener
        if (state is AbsentSuccess) {
          // absent deleting the records from list
          appCubit.clearAppointment(index: state.data_index);

          setState(() {});
          showSuccessSnackBar(context, state.SuccessMessage);
        } else if (state is AbsentFailed) {
          showErrorDialog(
              context: context,
              title: state.errorMessage!,
              content: state.apiMessage!,
              onRetry: () {
                context.read<DoctorAppointmentCubit>().markAsAbsent(
                    context: context,
                    patient_name: state.patinet_name,
                    appointment_id: state.appointment_id,
                    data_index: state.index);
              });
        } else if (state is CompletedSucces) {
          setState(() {});
          showSuccessSnackBar(context, state.message);
        } else if (state is CompletedFailed) {
          showErrorDialog(
            context: context,
            title: 'Completing ${state.appointment.patientName} shows Error!',
            content: state.error!,
            onRetry: () {
              appCubit.markAsCompleted(
                  context: context,
                  data: state.appointment,
                  index: state.data_index);
            },
          );
        } else if (state is CancelSucces) {
          setState(() {
            _selectedIds.clear();
            _selected_data_indexed.clear();
            _inSelectionMode = false;
          });
          showSuccessSnackBar(context, 'Appointments Canceled Successfully');
        } else if (state is CancelFailed) {
          showErrorDialog(
            context: context,
            title: 'Cancelation Failed!',
            content: state.error,
            onRetry: () {
              appCubit.cancelAppointmet(
                  context: context,
                  reason: state.reason,
                  app_ids: state.appointments_ids,
                  data_index: state.data_index);
            },
          );
        } else if (state is ReportSuccess) {
          setState(() {});
        }
        ;
      },
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Loadingindecator();
        } else if (state is AppointmentFailed) {
          return Center(
            child: Text(
              state.error!,
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is AppointmentSucess) {
          final data = appCubit.appointment;
          return Column(
            children: [
              SizedBox(
                height: !_inSelectionMode ? 0 : 10,
              ),
              if (_inSelectionMode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                        icon: Icons.select_all_rounded,
                        label: 'Select all',
                        color: midnigth_bule, // Color(0xFFC0C0C0),
                        onTap: () {
                          for (int i = 0; i < data.length; i++) {
                            _selectedIds.add(data[i].appointmentId);
                            _selected_data_indexed.add(i);
                          }
                          setState(() {});
                        }),
                    _buildActionButton(
                        icon: Icons.deselect_rounded,
                        label: 'Deselect all',
                        color: Color(
                            0xFFC0C0C0), //const Color.fromRGBO(233, 144, 138, 1),
                        onTap: () {
                          setState(() {
                            _selectedIds.clear();
                            _selected_data_indexed.clear();
                            _inSelectionMode = false;
                          });
                        }),
                    _buildActionButton(
                        icon: Icons.remove_circle_outline,
                        label: 'Cancel',
                        color: Colors.redAccent,
                        onTap: () {
                          // here to cancel the id set from api
                          showDialog(
                            context: context, // ← مهم إضافة context
                            builder: (context) => CancelReasonDialog(
                              onConfirm: (reason) {
                                // هنا تنفيذ عملية الإلغاء مع السبب
                                appCubit.cancelAppointmet(
                                    context: context,
                                    reason: reason,
                                    app_ids: _selectedIds.toList(),
                                    data_index:
                                        _selected_data_indexed.toList());
                              },
                              onCancel: () {},
                            ),
                          );
                        })
                  ],
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onDragDowntoRefresh,
                  child: ListView.builder(
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount:
                          appCubit.hasMoreApp ? data.length + 1 : data.length,
                      itemBuilder: (context, index) {
                        if (!_isRefreshing) {
                          if (index < data.length) {
                            return UpcomingAppointmentCard(
                              appointment: data[index],
                              isSelected: _selectedIds
                                  .contains(data[index].appointmentId),
                              toggleSelected: _toggleSelected,
                              selectionMode: _inSelectionMode,
                              onLongPressed: _triggerSelectionMode,
                              index: index,
                            );
                          } else {
                            return const SizedBox(
                              height: 50,
                              child: Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: lightBlue,
                              )),
                            );
                          }
                        }
                        return null;
                      }),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
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
