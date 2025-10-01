import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';

class CancelReasonDialog extends StatefulWidget {
  final String initialReason;
  final Function(String) onConfirm;
  final Function() onCancel;

  const CancelReasonDialog({
    Key? key,
    this.initialReason = '',
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  _CancelReasonDialogState createState() => _CancelReasonDialogState();
}

class _CancelReasonDialogState extends State<CancelReasonDialog> {
  final _formKey = GlobalKey<FormState>();
  String reason = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: whiteGreen,
      title: const Text(
        'Appointment Canceling',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: jomalhiriFont, color: midnigth_bule, fontSize: 20),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomeTextFormField(
              title: '',
              hintText: 'Enter the reasno of your Cnacelaion!',
              strok_color: midnigth_bule,
              maxLines: 2,
              onChanged: (data) {
                reason = data;
                _formKey.currentState?.validate();
              },
              validator: (value) {
                if (reason.trim().isEmpty) {
                  return 'Please submit your reason';
                }
                return null;
              },
            )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
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
            widget.onCancel();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              widget.onConfirm(reason);
            }
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
