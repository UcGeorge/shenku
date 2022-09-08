import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../config/config.dart';
import 'book.dart';
import 'history_item.dart';

class AppData extends Equatable {
  AppData({
    List<Book>? library,
    DateTime? dateModified,
    String? appDataId,
    this.appVersion = appVer,
    Map<String, BookHistoryItem>? history,
  })  : library = library ?? [],
        history = history ?? {},
        dateModified = dateModified ?? DateTime.now(),
        appDataId = appDataId ?? const Uuid().v4();

  factory AppData.empty() => AppData();

  factory AppData.fromJson(String source) =>
      AppData.fromMap(json.decode(source));

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      appDataId: map['appDataId'] ?? '',
      appVersion: map['appVersion'] ?? '',
      dateModified: DateTime.fromMillisecondsSinceEpoch(map['dateModified']),
      library: List<Book>.from(map['library']?.map((x) => Book.fromMap(x))),
      history: Map<String, BookHistoryItem>.from(map['history']),
    );
  }

  final String appDataId;
  final String appVersion;
  final DateTime dateModified;
  final Map<String, BookHistoryItem> history;
  final List<Book> library;

  @override
  List<Object> get props {
    return [
      appDataId,
      appVersion,
      dateModified,
    ];
  }

  AppData copyWith({
    String? appDataId,
    String? appVersion,
    DateTime? dateModified,
    List<Book>? library,
    Map<String, BookHistoryItem>? history,
  }) {
    return AppData(
      appDataId: appDataId ?? this.appDataId,
      appVersion: appVersion ?? this.appVersion,
      dateModified: dateModified ?? this.dateModified,
      library: library ?? this.library,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appDataId': appDataId,
      'appVersion': appVersion,
      'dateModified': dateModified.millisecondsSinceEpoch,
      'library': library.map((x) => x.toMap()).toList(),
      'history': history,
    };
  }

  String toJson() => json.encode(toMap());
}
