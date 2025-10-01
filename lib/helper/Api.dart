import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Api {
  Future<dynamic> GET(
      {required String URL, required String? token, String param = ''}) async {
    Map<String, String> header = {};
    if (token != null) {
      header.addAll(
          {'Authorization': 'Bearer $token', 'Accept': 'application/json'});
    }
    Response response = await get(Uri.parse(URL + param), headers: header);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(
          '${data['message'] ?? {data['error']} ?? 'Unknown Error'}');
    }
  }

  Future<dynamic> PATCH(
      {required String URL, required String? token, String param = ''}) async {
    Map<String, String> header = {};
    if (token != null) {
      header.addAll(
          {'Authorization': 'Bearer $token', 'Accept': 'application/json'});
    }
    Response response = await patch(Uri.parse(URL + param), headers: header);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(
          '${data['message'] ?? {data['error']} ?? 'Unknown Error'}');
    }
  }

  Future<dynamic> POST({
    required String URL,
    required Map<String, dynamic> body,
    required String? token,
    bool isMultipart = false, // ✅ مفتاح تحديد نوع الطلب
    File? file, // ✅ ملف إذا Multipart
    String fileKey = 'profile_picture', // مفتاح الملف
  }) async {
    if (isMultipart && file != null) {
      // إرسال Multipart
      var request = MultipartRequest('POST', Uri.parse(URL));
      request.headers['Accept'] = 'application/json';

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.fields
          .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      request.files.add(await MultipartFile.fromPath(fileKey, file.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception('${data['message'] ?? 'Unknown Error'}');
      }
    } else {
      // إرسال عادي
      Map<String, String> header = {
        'Content-Type': "application/x-www-form-urlencoded",
        'Accept': 'application/json',
      };

      if (token != null) {
        header['Authorization'] = 'Bearer $token';
      }

      final requestBody = body.map(
        (key, value) => MapEntry(key, value.toString()),
      );

      Response response =
          await post(Uri.parse(URL), body: requestBody, headers: header);
      var data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return data;
      } else {
        throw Exception(
            '${data['message'] ?? {data['error']} ?? 'Unknown Error'}');
      }
    }
  }

  Future<dynamic> POST_JSON({
    required String URL,
    required Map<String, dynamic> body,
    required String? token,
  }) async {
    try {
      // headers خاصة بـ JSON
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      // إضافة token إذا موجود
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      // تحويل الـ body إلى JSON string
      final String jsonBody = jsonEncode(body);

      // إرسال الطلب
      final Response response = await post(
        Uri.parse(URL),
        headers: headers,
        body: jsonBody,
      );

      // تحقق من status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Request failed');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timeout');
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> PUT(
      {required String URL,
      required dynamic body,
      required String? token}) async {
    Map<String, String> header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // or FormData it depends
      'Accept': 'application/json',
    };
    final requestBody = body.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    Response response =
        await put(Uri.parse(URL), body: requestBody, headers: header);
    var data = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Map <String,dynamic> (product)
      return data;
    } else {
      throw Exception(
          '${data['message'] ?? {data['error']} ?? 'Unknown Error'}');
    }
  }

  Future<dynamic> DELETE(
      {required String URL,
      required String? token,
      required Map<String, dynamic> body}) async {
    Map<String, String> header = {};
    if (token != null) {
      header.addAll(
          {'Authorization': 'Bearer $token', 'Accept': 'application/json'});
    }
    final requestBody = body.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    Response response =
        await delete(Uri.parse(URL), headers: header, body: requestBody);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(
          '${data['message'] ?? {data['error']} ?? 'Unknown Error'}');
    }
  }
}
