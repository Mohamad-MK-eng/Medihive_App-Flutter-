import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';

class ProfileImageContainer extends StatefulWidget {
  ProfileImageContainer(
      {this.hieght = 150,
      this.width = 150,
      required this.Image_path,
      this.strok_color = hardmintGreen});
  int width;
  int hieght;
  String? Image_path;
  Color strok_color;

  @override
  State<ProfileImageContainer> createState() => _ProfileImageContainerState();
}

class _ProfileImageContainerState extends State<ProfileImageContainer> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // String Image Path
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Appdimensions.getWidth(widget.width),
      height: Appdimensions.getHight(widget.hieght),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: CircleBorder(
            side: BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: widget.strok_color,
                width: 2)),

        // image: DecorationImage(image: image)
      ),
      child: widget.Image_path != null
          ? Image.network(
              fit: BoxFit.cover,
              widget.Image_path!,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/person.png',
                  fit: BoxFit.contain,
                ); // أو صورة افتراضية
              },
            )
          : Image.asset(
              PersonImage,
              fit: BoxFit.contain,
            ),
    );
  }
}
