import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';
import 'package:medihive_1_/helper/Custom_Dialog.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/models/Arguments_Models/final_docot_payment_date_info.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/widgets/Payment_choises_Row.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({required this.info});
  FinalDocotPaymentDateInfo info;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? selectedPayMethod;
  GlobalKey<FormState> key = GlobalKey();

  onTypeSelected(int index) {
    setState(() {
      selectedPayMethod = index;
    });
  }

  String? _wallet_pin;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final walletCubit = context.read<PatWalletCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hardmintGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration:
                  ShapeDecoration(color: Colors.white, shape: CircleBorder()),
              child: Center(
                  child: Icon(
                Icons.chevron_left,
                size: 40,
              )),
            ),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        progressIndicator: const Loadingindecator(),
        child: Column(
          children: [
            SizedBox(
              height: Appdimensions.screenHieght / 4.5,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${widget.info.doctor_fee}\$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontFamily: jomalhiriFont,
                    fontWeight: FontWeight.w700,
                    height: 0.19,
                    letterSpacing: 1.92,
                  ),
                ),
              ),
            ),
            BlocListener<PatWalletCubit, PatWalletState>(
              listener: (context, state) {
                if (state is BookingLoading) {
                  isloading = true;
                } else if (state is BookingFailed) {
                  setState(() {
                    isloading = false;
                  });
                  showErrorSnackBar(context, '${state.errorMessage}');
                } else if (state is BookingSuccess) {
                  setState(() {
                    isloading = false;
                  });
                  Navigator.pushNamed(context, Routes.appConfirmationPage,
                      arguments: walletCubit.appSuccessInfo!);
                } else if (state is WalletNotActivated) {
                  setState(() {
                    isloading = false;
                  });
                  showCustomDialog(
                      context: context,
                      type: CustomDialogType.warning,
                      title: 'Required Wallet Activation!',
                      content: state.errorMessage!,
                      onConfirm: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.profilePage,
                            arguments: 3,
                            ModalRoute.withName(Routes.patientHome));
                      });
                }
              },
              child: Expanded(
                  child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(35),
                            topStart: Radius.circular(35)))),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: const Text(
                        'Clinic Payment Method',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w500,
                          height: 0.50,
                          letterSpacing: 0.72,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Appdimensions.getHight(33),
                    ),
                    PaymentChoisesRow(
                      selectedPayMethod: selectedPayMethod,
                      onSelectedOne: onTypeSelected,
                    ),
                    SizedBox(
                      height: Appdimensions.getHight(45),
                    ),
                    selectedPayMethod == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Submit your wallet pin!",
                                style: TextStyle(
                                  color: hardGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Form(
                                key: key,
                                child: Pinput(
                                  length: 4,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Wallet Pin required!';
                                    } else if (value.length < 4) {
                                      return '4 digits required!';
                                    } else {
                                      _wallet_pin = value;
                                    }
                                    return null;
                                  },
                                  defaultPinTheme: PinTheme(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          border:
                                              Border.all(color: hardmintGreen),
                                          borderRadius:
                                              BorderRadius.circular(7.5))),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Expanded(child: const SizedBox()),
                    selectedPayMethod != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: CustomButton(
                              buttonText: 'Confirm',
                              onTap: () async {
                                if (selectedPayMethod == 1) {
                                  if (key.currentState!.validate()) {
                                    // ✅ كلشي تمام، نفذ العملية

                                    showCustomDialog(
                                        context: context,
                                        type: CustomDialogType.warning,
                                        title: 'Confirming required!',
                                        content:
                                            "You're about to book the appointment\n Fees will be taken of your wallet!",
                                        onConfirm: () async {
                                          setState(() {
                                            isloading = true;
                                          });

                                          walletCubit.bookingMethod(
                                              context,
                                              selectedPayMethod == 1,
                                              _wallet_pin,
                                              widget.info);
                                        });
                                  } else {
                                    // ❌ الفاليديشن فشل
                                  }
                                } else {
                                  // حالة الكاش

                                  showCustomDialog(
                                      context: context,
                                      type: CustomDialogType.warning,
                                      title: 'Confirming required!',
                                      content:
                                          "You're about to book the appointment\n Fees should be payed at clinic!",
                                      onConfirm: () async {
                                        walletCubit.bookingMethod(
                                            context, false, null, widget.info);
                                      });
                                }
                              },
                              isFontBig: true,
                              isWideButtons: false,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
