import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../config/config.dart';
import 'book.dart';

class AppData {
  AppData({
    this.appVersion = appVer,
    List<Book>? library,
    DateTime? dateModified,
    String? appDataId,
  })  : library = library ?? [],
        dateModified = dateModified ?? DateTime.now(),
        appDataId = appDataId ?? const Uuid().v4();

  factory AppData.empty() => AppData();

  factory AppData.fromJson(String source) =>
      AppData.fromMap(json.decode(source));

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      appVersion: map['appVersion'] ?? '',
      dateModified: DateTime.fromMillisecondsSinceEpoch(map['dateModified']),
      appDataId: map['appDataId'] ?? '',
      library: List<Book>.from(map['library']?.map((x) => Book.fromMap(x))),
    );
  }

  final String appDataId;
  final String appVersion;
  final DateTime dateModified;
  final List<Book> library;

  AppData copyWith({
    String? appVersion,
    DateTime? dateModified,
    String? appDataId,
    List<Book>? library,
  }) {
    return AppData(
      appVersion: appVersion ?? this.appVersion,
      dateModified: dateModified ?? this.dateModified,
      appDataId: appDataId ?? this.appDataId,
      library: library ?? this.library,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appVersion': appVersion,
      'dateModified': dateModified.millisecondsSinceEpoch,
      'appDataId': appDataId,
      'library': library.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
