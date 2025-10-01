import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

enum CustomDialogType {
  success,
  warning,
}

showCustomDialog({
  required BuildContext context,
  required CustomDialogType type,
  required String title,
  required String content,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
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
            type == CustomDialogType.success
                ? Icons.check_circle_outline
                : Icons.help_outline_outlined,
            color: type == CustomDialogType.success
                ? hardmintGreen
                : Colors.brown.shade300,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: montserratFont,
              fontWeight: FontWeight.w700,
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
          type == CustomDialogType.warning
              ? Row(
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
                        backgroundColor: mintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onConfirm != null) onConfirm();
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mintGreen, // أخضر هادئ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                  child: const Text("OK"),
                )
        ],
      ),
    ),
  );
}
