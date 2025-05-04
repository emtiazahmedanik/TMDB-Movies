import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:http/http.dart';
import 'package:tmdbmovies/data/utils/apiKey.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    required this.errorMessage,
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'accept': 'application/json',
        'Authorization': ApiKey.apiKey,
      };
      Response response = await get(uri, headers: headers);
      _preRequestLogging(url: url, body: response.body);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          errorMessage: "",
          data: decodedJson,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMsg =
            decodedJson["status_message"] ?? "Something went wrong";
        _logger.e(errorMsg);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMsg,
        );
      }
    } on Exception catch (e) {
      _logger.e(e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _preRequestLogging({required String url, String? body}) {
    _logger.i("Url=>$url \n Response Body=>$body");
  }
}
