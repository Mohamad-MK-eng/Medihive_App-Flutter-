import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

void showErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      overflow: TextOverflow.visible,
      maxLines: null,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    ),
    backgroundColor: Colors.redAccent.shade200,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    duration: const Duration(seconds: 1, milliseconds: 400),
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      overflow: TextOverflow.visible,
      maxLines: null,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
    ),
    backgroundColor: mintGreen,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    duration: const Duration(seconds: 2, milliseconds: 300),
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showOverlaySnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 0,
      left: 5,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.75,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // remove it after 3 seconds
  Future.delayed(Duration(seconds: 2)).then((_) => overlayEntry.remove());
}
