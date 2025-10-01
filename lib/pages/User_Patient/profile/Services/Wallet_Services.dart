import 'package:medihive_1_/constant/ApiRoutes.dart';
import 'package:medihive_1_/helper/Api.dart';
import 'package:medihive_1_/helper/Pagination_Result.dart';
import 'package:medihive_1_/helper/Result.dart';
import 'package:medihive_1_/models/Arguments_Models/PatWalletBalance.dart';
import 'package:medihive_1_/models/WalletTransactions.dart';

class WalletInfoService {
  getBalanceAndCheckActivationService({required String token}) async {
    try {
      var responseBody = await Api().GET(URL: getWalletInfoUrl, token: token);
      return PatWalletBalance.fromjson(responseBody);
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  activateWalletService(
      {required String token, required String wallet_pin}) async {
    Map<String, String> requestBody = {"pin": wallet_pin};

    try {
      await Api()
          .POST(URL: activatePatWalletUrl, body: requestBody, token: token);
      return true;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  changePinService(
      {required String token,
      required String oldPin,
      required String newPin}) async {
    Map<String, String> requestBody = {
      "current_pin": oldPin,
      "new_pin": newPin
    };
    try {
      await Api().POST(URL: changePinUrl, body: requestBody, token: token);
      return true;
    } on Exception catch (ex) {
      return ex.toString().substring(10);
    }
  }

  Future<ApiResult> getWalletTrasService(
      {required String token, int? page}) async {
    String? params;
    if (page != null) {
      params = '?page=$page';
    } else {
      params = '';
    }
    List<Wallettransactions> data = [];
    try {
      var resposeBody =
          await Api().GET(URL: getWalletTrasUrl, token: token, param: params);
      final data_list_body = resposeBody['data'];
      final last_page = resposeBody['pagination']['last_page'];
      for (int i = 0; i < data_list_body.length; i++) {
        data.add(Wallettransactions.fromJosn(data_list_body[i], last_page));
      }
      return ApiResult.success(
          PaginatedResult(items: data, last_page: last_page));
    } on Exception catch (ex) {
      return ApiResult.failure(ex.toString().substring(10));
    }
  }
}
