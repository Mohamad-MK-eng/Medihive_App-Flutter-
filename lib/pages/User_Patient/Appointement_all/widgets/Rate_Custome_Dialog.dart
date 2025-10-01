import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class RateCustomDialog extends StatelessWidget {
  final void Function(double rating)? onSubmit;

  RateCustomDialog(
      {this.onSubmit, required this.appointment_id, required this.rate_cubit});
  int appointment_id;
  MyAppointmentCubit rate_cubit;

  @override
  Widget build(BuildContext context) {
    double currentRating = 2.5;

    /* return BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
      buildWhen: (previous, current) {
        return current is RateSuccess ||
            current is RateFailed ||
            current is RateSuccess;
      },
      builder: (context, state) {
        if (state is RateLoading) {
          return const Loadingindecator();
        } else if (state is RateFailed) {
          return Center(
            child: Text(state.errorMessage!),
          );
        } else if (state is RateSuccess) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline, // أو Icons.check_circle_outline
                size: 64,
                color: hardmintGreen,
              ),
              const SizedBox(height: 16),
              const Text(
                "Thanks for your concern",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Your rating has been successfully submitted.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          );
        } */
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text(
        'Rate Your Experience',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: montserratFont,
          fontStyle: FontStyle.italic,
          color: hardGrey,
          fontSize: 18,
        ),
      ),
      content: BlocBuilder<MyAppointmentCubit, MyAppointmentState>(
        buildWhen: (previous, current) {
          return current is RateSuccess ||
              current is RateFailed ||
              current is RateLoading;
        },
        builder: (context, state) {
          if (state is RateLoading) {
            return const SizedBox(height: 150, child: const Loadingindecator());
          } else if (state is RateFailed) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 100,
                    child: Center(
                        child: Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                    ))),
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<MyAppointmentCubit>().rateInitilaEmti();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is RateSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline, // أو Icons.check_circle_outline
                  size: 64,
                  color: hardmintGreen,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Thanks for your concern",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your rating has been successfully submitted.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<MyAppointmentCubit>().rateInitilaEmti();

                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            );
          }
          return StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar(
                  initialRating: currentRating,
                  glow: false,
                  updateOnDrag: true,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star_rounded, color: hardmintGreen),
                    half: Icon(Icons.star_half_rounded, color: hardmintGreen),
                    empty:
                        Icon(Icons.star_border_rounded, color: hardmintGreen),
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      currentRating = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Rating: ${currentRating.toStringAsFixed(1)} ⭐',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop();
                        //  if (onCancel != null) onCancel();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.read<MyAppointmentCubit>().rateAppMethod(
                            context: context,
                            appointment_id: appointment_id,
                            rate: currentRating);
                        //  onSubmit!(currentRating);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
