// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientResponse {
  final dynamic body;
  final String? statusCode;
  final Uri requestUrl;
  ClientResponse({
    required this.body,
    required this.statusCode,
    required this.requestUrl,
  });

  bool get success => statusCode?.startsWith('2') == true;
}
