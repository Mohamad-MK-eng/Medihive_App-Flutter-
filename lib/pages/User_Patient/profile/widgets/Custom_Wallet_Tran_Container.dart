import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/models/WalletTransactions.dart';

class CustomWalletTranContainer extends StatelessWidget {
  CustomWalletTranContainer({required this.tranc});
  Wallettransactions tranc;
  @override
  Widget build(BuildContext context) {
    bool typedeposit = tranc.isPayment;
    return typedeposit
        ? Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            //  height: Appdimensions.getHight(100),
            decoration: ShapeDecoration(
              color: lightSky.withOpacity(0.75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          const Text(
                            'serial: ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${tranc.serial}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                          Expanded(child: const SizedBox()),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              // 01:34 PM
                              tranc.date,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: const Text(
                              'Clinic: ',
                              style: TextStyle(
                                color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tranc.clinic ?? 'Any',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                          Expanded(child: const SizedBox()),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tranc.time,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Arial',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: const Text(
                              'Doctor: ',
                              style: TextStyle(
                                color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tranc.doctor_name ?? 'Doctor',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const Text(
                            'Ammount: ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '-${tranc.ammount} \$',
                            style: const TextStyle(
                              color: const Color(0xFFEB4335),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                    right: 1,
                    bottom: 1,
                    child: Icon(
                      Icons.money_off,
                      size: 40,
                      color: const Color(0xFFEB4335),
                    ))
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            //  height: Appdimensions.getHight(100),
            decoration: ShapeDecoration(
              color: lightSky.withOpacity(0.75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        children: [
                          const Text(
                            'serial: ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${tranc.serial}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                          Expanded(child: const SizedBox()),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              // 01:34 PM
                              tranc.date,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: const Text(
                              'Charged by: ',
                              style: TextStyle(
                                color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tranc.charged_by ?? secretaryName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                          Expanded(child: const SizedBox()),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tranc.time,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Arial',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const Text(
                            'Ammount: ',
                            style: TextStyle(
                              color: const Color(0xFFA9A9A9) /* Dark-Gray */,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '+${tranc.ammount} \$',
                            style: const TextStyle(
                              color: hardmintGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Positioned(
                    right: 1,
                    bottom: 1,
                    child: Icon(
                      Icons.money_off,
                      size: 40,
                      color: hardmintGreen,
                    ))
              ],
            ),
          );
  }
}
