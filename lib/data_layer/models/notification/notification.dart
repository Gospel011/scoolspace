// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'notification.g.dart';

@HiveType(typeId: 2)
class Notification {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final Map<String, dynamic>? payload;
  @HiveField(4)
  final DateTime dateCreated;
  Notification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    required this.dateCreated,
  });

  Notification copyWith({
    String? id,
    String? title,
    String? body,
    Map<String, dynamic>? payload,
    DateTime? dateCreated,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      payload: map['payload'] != null
          ? Map<String, dynamic>.from((map['payload'] as Map<String, dynamic>))
          : null,
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, body: $body, payload: $payload, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        mapEquals(other.payload, payload) &&
        other.dateCreated == dateCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        payload.hashCode ^
        dateCreated.hashCode;
  }
}
