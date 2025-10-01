import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class CustomeTextFormField extends StatefulWidget {
  CustomeTextFormField(
      {this.hintText,
      this.onChanged,
      this.isPassword = false,
      this.obscuretext = false,
      required this.title,
      this.validator,
      this.maxLines = 1,
      this.customeWidth = double.infinity,
      this.readOnly = false,
      this.isNumber = false,
      this.onDateTapped,
      this.focusNode,
      this.strok_color = mintGreen,
      this.title_color = lightBlue});

  String? hintText;
  Function(String)? onChanged;
  bool isPassword;
  String title;
  bool obscuretext;

  final FormFieldValidator<String>? validator;
  int maxLines;
  double customeWidth;
  Color strok_color;
  Color title_color;
  bool readOnly;
  bool isNumber;
  VoidCallback? onDateTapped;
  FocusNode? focusNode;

  @override
  State<CustomeTextFormField> createState() => _CustomeTextFormFieldState();
}

class _CustomeTextFormFieldState extends State<CustomeTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " ${widget.title}",
          style: TextStyle(
            color: widget.title_color,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: Appdimensions.screenWidth *
              (widget.customeWidth) /
              Appdimensions.vPhoneWidth,
          child: TextFormField(
            focusNode: widget.focusNode,
            keyboardType:
                widget.isNumber ? TextInputType.number : TextInputType.text,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            expands: false,
            onTap: widget.onDateTapped,
            validator: widget.validator == null
                ? (data) {
                    if (widget.isPassword) {
                      if (data!.trim().length < 8)
                        return 'Password is at least 8 characters';
                    } else {
                      if (data!.trim().isEmpty) return 'Invalid Content';
                    }
                    return null;
                  }
                : widget.validator,
            onTapOutside: (event) {
              widget.focusNode?.unfocus();
            },
            onChanged: widget.onChanged,
            obscureText: widget.obscuretext,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 14, //
                horizontal: 12,
              ),
              // suffix icon
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        widget.obscuretext = !widget.obscuretext;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: hardmintGreen,
                      ))
                  : null,
              // هاد بس يطلع ايرور ويكون مو مفوكس
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: mintGreen),
              ),
              hintStyle: TextStyle(
                  color: geryinAuthTextField, fontWeight: FontWeight.w500),
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: widget.strok_color, width: 1.5)),
              // هاد بيظغى على border  وقت يكون مفوكس
            ),
          ),
        ),
      ],
    );
  }
}
