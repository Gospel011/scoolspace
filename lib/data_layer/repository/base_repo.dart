
import 'package:schoolspace/data_layer/api_client.dart';
import 'package:schoolspace/data_layer/models/client_response.dart';
import 'package:schoolspace/data_layer/models/helper_models/file_model.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

abstract class BaseRepo {
  const BaseRepo([this.apiClient = const ApiClient()]);

  final ApiClient apiClient;

  /// Extracts the actual response models  that can be returned from
  /// the api call Map<String, dynamic> response.
  dynamic extractMessage(ClientResponse response);

  // //? MAKE REQUEST
  Future<dynamic> makeRequest(
      {required String endpoint,
      String? token,
      Map<String, dynamic>? body,
      String? baseUrl,
      String method = 'GET'}) async {
    final response = await ApiClient.makeRequest(
        endpoint: endpoint,
        body: body ?? {},
        token: token,
        method: method,
        baseUrl: baseUrl);

    log.i(response);
    return extractMessage(response);
  }

  //? MAKE REQUEST
  Future<dynamic> makeMultipartRequest(
      {required String endpoint,
      required String token,
      Map<String, String>? body,
      File? file,
      List<File>? files,
      String? baseUrl,
      String method = 'POST'}) async {
    // final response = {"success": true};
    final response = await ApiClient.makeMultiPartRequest(
        endpoint: endpoint,
        file: file,
        files: files,
        body: body ?? {},
        baseUrl: baseUrl,
        token: token,
        method: method);

    log.i(response);
    return extractMessage(response);
  }
}
