import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'dart:convert';

import 'package:schoolspace/data_layer/models/client_response.dart';
import 'package:schoolspace/data_layer/models/helper_models/error_model.dart';
import 'package:schoolspace/data_layer/models/helper_models/file_model.dart';
import 'package:schoolspace/utils/constants.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class ApiClient {
  const ApiClient();
  static Future<ClientResponse> makeRequest({
    required String endpoint,
    String? token,
    String method = 'POST',
    required Map<String, dynamic> body,
    String? baseUrl,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final url = '${(baseUrl ?? AppConstants.baseUrl)}/$endpoint';
    final uri = Uri.parse(url);

    log.i("REQUEST URL IS $url");

    var request = http.Request(method.toUpperCase(), uri);

    request.body = json.encode(body);
    request.headers.addAll(headers);

    String? statusCode;

    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: AppConstants.timeout),
            onTimeout: _onTimeout,
          );
      statusCode = response.statusCode.toString();

      String responseStr = await response.stream.bytesToString();

      log.i("R E S P O N S E S T R   $responseStr");

      final responseObj = jsonDecode(responseStr);

      _extractToken(response, responseObj);

      // log("FINAL RESPONSE OBJECT: ${responseObj}");

      return ClientResponse(
          body: responseObj, statusCode: statusCode, requestUrl: uri);
    } catch (e) {
      // TODO
      // log(":::::::: e is $e");
      return ClientResponse(
          body: AppError.handleError(e),
          statusCode: statusCode,
          requestUrl: uri);
    }
  }

  static Future<ClientResponse> makeMultiPartRequest(
      {required String token,
      required String endpoint,
      required String method,
      required Map<String, String> body,
      File? file,
      String? baseUrl,
      List<File>? files}) async {
    //? SETUP REQUEST HEADER
    var headers = {'Authorization': 'Bearer $token'};

    //? SETUP URL
    final Uri url =
        Uri.parse('${(baseUrl ?? AppConstants.baseUrl)}/$endpoint');

    //? INITIALIZE MULTI-PART REQUEST
    var request = http.MultipartRequest(method.toUpperCase(), url);

    //? ADD REQUEST BODY
    request.fields.addAll(body);

    //? ADD ANY FILES
    // String? contentType;

    // if (file != null) contentType = file.headers?['Content-Type'];

    MediaType? mediaType;
    // if (contentType != null) {
    //   mediaType =
    //       MediaType(contentType.split('/')[0], contentType.split('/')[1]);
    // }
    try {
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
            file.name, file.path,
            contentType: mediaType));
      }
      if (files != null && files.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          request.files.add(
              await http.MultipartFile.fromPath(files[i].name, files[i].path));
        }
      }

      // log("::: R E Q U E S T   F I L E S   ${request.files} :::");
      log.i(
          "::: R E Q U E S T   F I L E S   ${request.files.first.contentType} :::");
    } catch (e) {
      log.i(e);
    }

    request.headers.addAll(headers);

    // if (file != null && file.headers != null)
    //   request.headers.addAll(file.headers!);

    // log(":::::Headers: ${request.headers}");

    try {
      log.i("First breakpoint");

      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: AppConstants.timeout),
            onTimeout: _onTimeout,
          );

      log.i("Second breakpoint");

      return ClientResponse(
          body: jsonDecode(await response.stream.bytesToString()),
          statusCode: response.statusCode.toString(),
          requestUrl: url);
    } catch (e) {
      return ClientResponse(
          body: AppError.handleError(e), statusCode: null, requestUrl: url);
    }
  }

  //? H E L P E R   M E T H O D S
  static FutureOr<http.StreamedResponse> _onTimeout() {
    const timeoutResponse = {
      "status": "fail",
      "msg": "Request timeout. please check your internet connection"
    };

    List<int> byte = utf8.encode(jsonEncode(timeoutResponse));

    Stream<List<int>> byteStream = Stream.fromIterable([byte]);

    return http.StreamedResponse(byteStream, 400,
        headers: AppConstants.defaultHeader);
  }

  static void _extractToken(http.StreamedResponse response, responseObj) {
    if (response.headers['authorization'] != null) {
      responseObj['token'] = response.headers['authorization'];
    }
  }
}
