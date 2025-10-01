import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/models/Arguments_Models/PatWalletBalance.dart';
import 'package:medihive_1_/models/Arguments_Models/final_docot_payment_date_info.dart';
import 'package:medihive_1_/models/WalletTransactions.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/services/Booking_Service.dart';
import 'package:medihive_1_/pages/User_Patient/profile/Services/Wallet_Services.dart';

part 'pat_wallet_state.dart';

class PatWalletCubit extends Cubit<PatWalletState> {
  PatWalletCubit() : super(PatWalletInitial());

  PatWalletBalance? walletInfo;
  AppSuccessInfo? appSuccessInfo;
  List<Wallettransactions> transData = [];
  int pageNum = 1; // initail value

  bool hasMoreTrans = true;
  int counter = -1;
  bookingMethod(BuildContext context, bool isWallet, String? walletPin,
      FinalDocotPaymentDateInfo date_info) async {
    emit(BookingLoading());
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;

      if (accessToken != null) {
        if (isWallet) {
          var walletResponse = await BookingService()
              .bookAppWalletService(date_info, walletPin!, accessToken);
          if (walletResponse is String) {
            // فشل
            _checkBookErrorType(walletResponse);
          } else {
            // نجح
            appSuccessInfo = walletResponse;
            emit(BookingSuccess());
          }
        } else {
          var cashResponse =
              await BookingService().bookAppCashService(date_info, accessToken);
          if (cashResponse is String) {
            // فشل
            emit(BookingFailed(cashResponse));
          } else {
            // نجح
            appSuccessInfo = cashResponse;
            emit(BookingSuccess());
          }
        }
      } else {
        emit(BookingFailed('UnAuthorized'));
      }
    } on Exception catch (ex) {
      emit(BookingFailed(ex.toString()));
    }
  }

  getWalletInfoMethod({required BuildContext context}) async {
    emit(WalletInfoLoading());
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken != null) {
        var response = await WalletInfoService()
            .getBalanceAndCheckActivationService(token: accessToken);

        if (response is PatWalletBalance) {
          walletInfo = response;

          emit(WalletInfonSuccess());
          return;
          //
        } else if (response is String) {
          if (response.contains(
              'Please activate your wallet before checking balance')) {
            emit(WalletNotActivated(response));

            return;
          } else {
            emit(WalletInfoFailed(response));
            return;
          }
        } else {
          emit(WalletInfoFailed('UnKnown Error'));
          return;
        }
      } else {
        emit(WalletInfoFailed('UnAuthorized'));
        return;
      }
    } on Exception catch (ex) {
      emit(WalletInfoFailed(ex.toString()));
    }
  }

  activateWallet(
      {required BuildContext context, required String wallet_pin}) async {
    emit(ActivationLaoding());
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken != null) {
        var response = await WalletInfoService()
            .activateWalletService(token: accessToken, wallet_pin: wallet_pin);

        if (response == true) {
          emit(ActivationSuccess());
          return;
          //
        } else {
          emit(ActivationFailed('$response'));

          return;
        }
      } else {
        emit(ActivationFailed('UnAuthorized'));

        return;
      }
    } on Exception catch (ex) {
      emit(ActivationFailed(ex.toString()));
    }
  }

  changePinMethod(
      {required BuildContext context,
      required String oldPin,
      required String newPin}) async {
    emit(ChangePinLaoding());
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken != null) {
        var response = await WalletInfoService().changePinService(
            token: accessToken, oldPin: oldPin, newPin: newPin);

        if (response == true) {
          emit(ChangePinSuccess());
          return;
          //
        } else {
          emit(ChangePinFailed('$response'));

          return;
        }
      } else {
        emit(ChangePinFailed('UnAuthorized'));

        return;
      }
    } on Exception catch (ex) {
      emit(ChangePinFailed(ex.toString()));
    }
  }

  Future<void> getWalletTransactions(
      {required BuildContext context, bool paginating = false}) async {
    try {
      final accessToken = BlocProvider.of<AuthCubit>(context).access_token;
      if (accessToken == null) {
        emit(TransFailed('UnAuthorized'));
        return;
      }

      // إذا كان طلب ترقيم صفحات
      if (paginating) {
        await _handelPagTras(token: accessToken);
      } else {
        await _handelInitailTras(token: accessToken);
      }
    } catch (e) {
      emit(TransFailed(e.toString()));
    }
  }

  Future<void> _handelInitailTras({required String token}) async {
    emit(TransLaoding());
    var result = await WalletInfoService().getWalletTrasService(token: token);
    if (result.isSuccess) {
      pageNum++;
      hasMoreTrans = pageNum <= result.data.last_page;
      transData.addAll(result.data.items);

      emit(TransSuccess());

      return;
    }
    emit(TransFailed(result.error));
  }

  // internal functions
  Future<void> _handelPagTras({required String token}) async {
    if (!hasMoreTrans) return;
    emit(PagTransLaoding());
    var result = await WalletInfoService()
        .getWalletTrasService(token: token, page: pageNum);
    if (result.isSuccess) {
      pageNum++;
      hasMoreTrans = pageNum <= result.data.last_page;
      transData.addAll(result.data.items);

      emit(PagTransSuccess());
      return;
    }
    emit(PagTransFailed(result.error));
  }

  _checkBookErrorType(String response) {
    if (response
        .contains('Please activate your wallet before making payments')) {
      emit(WalletNotActivated(response));
    } else {
      emit(BookingFailed(response));
    }
  }
}
