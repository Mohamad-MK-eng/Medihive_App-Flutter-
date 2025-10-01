import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

showErrorDialog({
  required BuildContext context,
  VoidCallback? onRetry,
  VoidCallback? onCancel,
  required String title,
  required String content,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40), // تصغير العرض
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: whiteGreen,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            color: Colors.redAccent.shade200,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: montserratFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: montserratFont,
              fontStyle: FontStyle.italic,
              color: geryinAuthTextField,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Cancel Button - لون أحمر هادئ
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              // Confirm Button - لون أخضر هادئ
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: midnigth_bule.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onRetry != null) onRetry();
                },
                child: const Text(
                  "Retry",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
