import 'package:flutter/material.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';

import '../../../../constant/Colors&Fonts.dart';

class CustomDropDowMenu extends StatefulWidget {
  CustomDropDowMenu(
      {required this.items,
      required this.title,
      required this.isEnabled,
      required this.onSelectedItme,
      this.hintText});
  List<String> items;
  String title;
  bool isEnabled;
  Function(String?) onSelectedItme;
  String? hintText;

  @override
  State<CustomDropDowMenu> createState() => _CustomDropDowMenuState();
}

class _CustomDropDowMenuState extends State<CustomDropDowMenu> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: lightBlue,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: mintGreen, width: 1.5),
          ),
          child: GestureDetector(
            onTap: () {
              if (!widget.isEnabled) {
                showErrorSnackBar(
                  context,
                  'Sorry 🙏, this information cannot be edited!',
                );
              }
            },
            child: AbsorbPointer(
              absorbing: !widget.isEnabled,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedItem,
                  hint: Align(
                      alignment: Alignment.center,
                      child: Text(
                          widget.hintText == null
                              ? "Select yours"
                              : widget.hintText!,
                          style: TextStyle(fontSize: 16))),
                  icon: const Icon(Icons.arrow_drop_down, color: hardmintGreen),
                  isExpanded: true, // ياخد كل العرض المتاح
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  dropdownColor: Colors.grey.shade100,

                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        if (widget.hintText != null) {
                          showErrorSnackBar(context,
                              'Sorry🙏,This informatio can not be editeed!');
                        }
                      },
                      value: item,

                      // هون لأول مرة فقط
                      enabled: widget.isEnabled,
                      child: Align(
                        // alignment: Alignment.center,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontFamily: montserratFont,
                            fontWeight: selectedItem == item
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                selectedItem == item ? Colors.black : hardGrey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue;
                      widget.onSelectedItme(newValue);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
