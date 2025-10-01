import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/models/Arguments_Models/final_docot_payment_date_info.dart';

class BookingService {
  bookAppWalletService(FinalDocotPaymentDateInfo date_info, String walletPin,
      String token) async {
    Map<String, dynamic> body = {
      'doctor_id': date_info.doctor_id,
      'slot_id': date_info.slot_id,
      'method': 'wallet',
      'wallet_pin': walletPin
    };
    try {
      var responseBody =
          await Api().POST(URL: getAndbookAppUrl, body: body, token: token);
      return AppSuccessInfo.fromJson(responseBody);
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  bookAppCashService(FinalDocotPaymentDateInfo date_info, String token) async {
    Map<String, dynamic> body = {
      'doctor_id': date_info.doctor_id,
      'slot_id': date_info.slot_id,
      'method': 'cash',
    };
    try {
      var responseBody =
          await Api().POST(URL: getAndbookAppUrl, body: body, token: token);
      return AppSuccessInfo.fromJson(responseBody);
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }
}
