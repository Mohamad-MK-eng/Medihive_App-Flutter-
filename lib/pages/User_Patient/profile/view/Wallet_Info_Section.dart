import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/User_Patient/profile/view/Wallet_Transactions_Page.dart';
import 'package:medihive_1_/shared/Custom_Button.dart';
import 'package:medihive_1_/shared/Custom_TextFormField.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';

class WalletInfoSection extends StatefulWidget {
  WalletInfoSection({required this.selectedHeader});
  int selectedHeader;
  State<WalletInfoSection> createState() => _WalletInfoSectionState();
}

class _WalletInfoSectionState extends State<WalletInfoSection> {
  bool isActivated = true;

  String? walletPin;
  GlobalKey<FormState> formkey = GlobalKey();
  List<int> tranTypes = [0, 1];

  @override
  void initState() {
    super.initState();
  }

  void setActivation(bool value) {
    isActivated = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final walletcubit = context.read<PatWalletCubit>();
    if (walletcubit.walletInfo == null) {
      walletcubit.getWalletInfoMethod(context: context);
    }
    return isActivated
        ? widget.selectedHeader == 1
            ? BlocConsumer<PatWalletCubit, PatWalletState>(
                listenWhen: (previous, current) {
                  return current is WalletNotActivated;
                },
                listener: (context, state) {
                  if (state is WalletNotActivated) {
                    setActivation(false);
                  }
                },
                buildWhen: (previous, current) {
                  if (current is WalletInfonSuccess ||
                      current is WalletInfoFailed ||
                      current is WalletNotActivated) {
                    return true;
                  } else
                    return false;
                },
                builder: (context, state) {
                  if (state is WalletInfoLoading) {
                    return const Loadingindecator();
                  } else if (state is WalletInfoFailed) {
                    return Center(
                      child: Text(state.errorMessage!),
                    );
                  } else if (state is WalletInfonSuccess ||
                      walletcubit.walletInfo != null) {
                    final walletinfo = walletcubit.walletInfo;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: Appdimensions.screenWidth * (0.3),
                              height: Appdimensions.getHight(100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Balance',
                                    style: TextStyle(
                                      color: hardmintGreen,
                                      fontSize: 14,
                                      fontFamily: 'Jomolhari',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.56,
                                    ),
                                  ),
                                  Text(
                                    '${walletinfo!.balance} \$',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //   fontFamily: 'Jomolhari',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.64,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: geryinAuthTextField,
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: Appdimensions.screenWidth * (0.3),
                              height: Appdimensions.getHight(100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Activation Date',
                                    style: TextStyle(
                                      color: hardmintGreen,
                                      fontSize: 14,
                                      fontFamily: 'Jomolhari',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.56,
                                    ),
                                  ),
                                  Text(
                                    '${walletinfo.activationDate}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      //  fontFamily: 'Jomolhari',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.64,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: geryinAuthTextField,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else
                    return SizedBox(
                      child: Text(state.toString()),
                    );
                },
              )
            : WalletTransactionsPage()
        : BlocConsumer<PatWalletCubit, PatWalletState>(
            listenWhen: (previous, current) {
              return current is ActivationFailed ||
                  current is ActivationSuccess;
            },
            listener: (context, state) {
              if (state is ActivationSuccess) {
                setActivation(true);
              } else if (state is ActivationFailed) {
                showErrorSnackBar(context, '${state.errorMessage}');
              }
            },
            buildWhen: (previous, current) {
              return current is ActivationFailed ||
                  current is ActivationSuccess;
            },
            builder: (context, state) {
              if (state is ActivationLaoding) {
                return const Loadingindecator();
              } else if (state is ActivationFailed) {
                return Center(
                  child: Text(state.errorMessage!),
                );
              } else
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomeTextFormField(
                            title: 'Wallet Pin',
                            hintText: 'Type a Wallet Pin of 4 digits!',
                            isPassword: true,
                            obscuretext: true,
                            isNumber: true,
                            onChanged: (data) {
                              walletPin = data;
                              formkey.currentState!.validate();
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Wallet Pin Required!';
                              } else if (value.length != 4) {
                                return '4 Digits Required!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomeTextFormField(
                            title: '',
                            hintText: 'ReType your Pin!',
                            isPassword: true,
                            obscuretext: true,
                            isNumber: true,
                            onChanged: (data) {
                              formkey.currentState!.validate();
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Pin Confimation required!';
                              } else if (value != walletPin) {
                                return "Pin dos'nt mathch!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Appdimensions.getHight(125),
                            child: Center(
                              child: Text(
                                "Note: Wallet could be charged only by \n Clinics'secretaries ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, color: geryinAuthTextField),
                              ),
                            ),
                          ),
                          CustomButton(
                            buttonText: 'Activate Wallet',
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                walletcubit.activateWallet(
                                    context: context, wallet_pin: walletPin!);
                              }
                            },
                            isFontBig: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            },
          );
  }
}
