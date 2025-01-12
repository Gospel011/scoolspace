// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:schoolspace/data_layer/models/client_response.dart';
import 'package:schoolspace/data_layer/models/user/user.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class ApiResponse {
  final bool success;
  final String? message;
  final User? user;
  final String? token;
  ApiResponse({
    required this.success,
    this.message,
    this.user,
    this.token,
  });

  factory ApiResponse.fromMap(
      {Map<String, dynamic>? body, ClientResponse? response}) {
    final String? urlPath = response?.requestUrl.path;
    final String? urlHost = response?.requestUrl.host;
    final Map<String, String>? queryParameters =
        response?.requestUrl.queryParameters;

    final bool success =
        (response?.statusCode?.startsWith('200') ?? body?['success']) == true;

    final map = body ?? response?.body;
    final isMap = map.runtimeType.toString().contains('Map<String, dynamic>');

    // Fields to Extract
   

    log.i(map);

    return ApiResponse(
      success: success,
      message: map['message']?.toString(),
      user: isMap && map['data'] != null && map['data']['user'] != null
          ? User.fromMap(map['data']['user'])
          : null,
      token: isMap ? map['token'] : null,
    );
  }

  //* HELPER METHODS

}
