import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/ImagePath.dart';
import 'package:medihive_1_/models/MyAppointment.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/App_Operation_container.dart';

class AppointmentContainer extends StatelessWidget {
  AppointmentContainer(
      {required this.appData,
      required this.button_1_Title,
      required this.button_1_type,
      required this.onButton_1_Taped,
      required this.button_2_Title,
      required this.button_2_type,
      required this.onButton_2_Taped});
  Myappointment appData;
  String button_1_Title;
  String button_2_Title;
  AppOperations button_1_type;
  AppOperations button_2_type;
  VoidCallback onButton_1_Taped;
  VoidCallback onButton_2_Taped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: Appdimensions.getWidth(360),
      // height: Appdimensions.getHight(100),
      decoration: ShapeDecoration(
        color: lightSky,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appData.full_date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                appData.app_state ?? 'pending',
                style: TextStyle(
                  color: hardmintGreen,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          const Divider(
            height: 7,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            // انتبه اذا ما كان الارفاع نفسه بالصورة تفسه يلي بSizedbox بيفرش
            height: Appdimensions.getHight(80),
            child: Row(
              children: [
                Container(
                  height: Appdimensions.getHight(80),
                  width: Appdimensions.getWidth(65),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: appData.doctor_ifon.image_path != null
                      ? Image.network(
                          fit: BoxFit.cover,
                          appData.doctor_ifon.image_path!,
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
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dr.${appData.doctor_ifon.first_name} ${appData.doctor_ifon.last_name}',
                      style: TextStyle(
                        color: const Color(0xFF1E1F2E),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      appData.clinic_name,
                      style: TextStyle(
                        color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Appointment id: ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '${appData.appointment_id}',
                            style: TextStyle(
                              color: const Color(0xFF00BFA6),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Expanded(child: const SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppOperationContainer(
                      tilte: button_1_Title,
                      type: button_1_type,
                      onTap: onButton_1_Taped,
                    ),
                    AppOperationContainer(
                      tilte: button_2_Title,
                      type: button_2_type,
                      onTap: onButton_2_Taped,
                    )
                  ],
                )
              ],
            ),
          ),
          /*  const Divider(
            height: 10,
          ),
          /*    const SizedBox(
            height: 5,
          ), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppOperationContainer(
                tilte: 'Cancel',
                isPayment: true,
              ),
              AppOperationContainer(
                tilte: 'Reshedual',
                isPayment: false,
              )
            ],
          ) */
        ],
      ),
    );
  }
}
