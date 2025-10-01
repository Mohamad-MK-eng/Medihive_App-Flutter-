import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';

class Doctorcontainer extends StatefulWidget {
  Doctorcontainer(
      {required this.image_path,
      required this.doctor_name,
      required this.doctor_speciality,
      required this.experience_years,
      required this.rate,
      this.shadowenabled = true});
  String? image_path;
  String doctor_name;
  String doctor_speciality;
  int? experience_years;
  double? rate;
  bool shadowenabled;

  @override
  State<Doctorcontainer> createState() => _DoctorcontainerState();
}

class _DoctorcontainerState extends State<Doctorcontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        width: Appdimensions.getWidth(360),
        height: Appdimensions.getHight(100),
        decoration: ShapeDecoration(
          color: lightSky,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: widget.shadowenabled ? Color(0x3F000000) : Colors.white,
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: Appdimensions.getWidth(65),
              height: Appdimensions.getHight(80),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: widget.image_path != null
                  ? Image.network(
                      fit: BoxFit.cover,
                      widget.image_path!,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          PersonImage,
                          fit: BoxFit.cover,
                        ); // أو صورة افتراضية
                      },
                    )
                  : Image.asset(
                      PersonImage,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr.${widget.doctor_name}',
                    style: const TextStyle(
                      color: const Color(0xFF1E1F2E),
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${widget.doctor_speciality}',
                    style: const TextStyle(
                      color: geryinAuthTextField /* Dark-Gray */,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.experience_years != null
                            ? '+${widget.experience_years} Years'
                            : '+3 Years',
                        style: const TextStyle(
                          color: geryinAuthTextField /* Dark-Gray */,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 26,
                              color: Color(0xFFFFD33C),
                            ),
                            Text(
                              widget.rate != null ? ' ${widget.rate}' : ' 4.2',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
