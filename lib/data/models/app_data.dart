import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../config/config.dart';

class AppData {
  AppData({
    this.appVersion = appVer,
  })  : dateModified = DateTime.now(),
        appDataId = const Uuid().v4();

  factory AppData.empty() => AppData();

  factory AppData.fromJson(String source) =>
      AppData.fromMap(json.decode(source));

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      appVersion: map['appVersion'] ?? '',
    );
  }

  final String appVersion;
  final DateTime dateModified;
  final String appDataId;

  AppData copyWith({
    String? appVersion,
  }) {
    return AppData(
      appVersion: appVersion ?? this.appVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appVersion': appVersion,
    };
  }

  String toJson() => json.encode(toMap());
}
