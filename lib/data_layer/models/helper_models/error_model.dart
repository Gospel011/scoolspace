// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:schoolspace/data_layer/models/client_response.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class AppError {
  final String title;
  final String content;
  const AppError({required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
    };
  }

  static AppError errorObject(ClientResponse response) {
    return AppError(
        title: response.body["title"] ?? 'Error',
        content: response.body['msg'] ?? response.body["message"]);
  }

  factory AppError.fromMap(Map<String, dynamic> map) {
    return AppError(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  static Map<String, String> handleError(Object e) {
    // String errno = "$e".split('errno = ')[1].split('),')[0];
    // log("E R R O R NUMBER IS $errno :::");
    log.e(" E R R IS $e");
    if (e is http.ClientException || e is TlsException) {
      return {
        "title": "Network Error",
        "message":
            "Please check your internet connection or switch to a different network."
      };
    } else {
      // log("U N K N O W N ERROR IS $e");
      return {
        "title": "Something went wrong",
        "code": "100",
        "message": "Please try again later."
      };
    }
  }

  String toJson() => json.encode(toMap());

  factory AppError.fromJson(String source) =>
      AppError.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppError(title: $title, content: $content)';
}
