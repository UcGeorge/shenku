import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'chapter.dart';
import 'shen_image.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.name,
    required this.type,
    required this.link,
    required this.source,
    this.status,
    this.rating,
    this.description,
    this.chapterCount,
    this.coverPicture,
    this.chapters,
  });

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: bookTypeFromMap(map['type']),
      link: map['link'] ?? '',
      source: map['source'] ?? '',
      status: map['status'] != null ? bookStatusFromMap(map['status']) : null,
      rating: map['rating'],
      description: map['description'],
      chapterCount: map['chapterCount']?.toInt(),
      coverPicture: map['coverPicture'] != null
          ? ShenImage.fromMap(map['coverPicture'])
          : null,
      chapters: map['chapters'] != null
          ? List<Chapter>.from(map['chapters']?.map((x) => Chapter.fromMap(x)))
          : null,
    );
  }

  final int? chapterCount;
  final List<Chapter>? chapters;
  final ShenImage? coverPicture;
  final String? description;
  final String id;
  final String link;
  final String name;
  final String? rating;
  final String source;
  final BookStatus? status;
  final BookType type;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toMap(),
      'link': link,
      'source': source,
      'status': status?.toMap(),
      'rating': rating,
      'description': description,
      'chapterCount': chapterCount,
      'coverPicture': coverPicture?.toMap(),
      'chapters': chapters?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  static bookTypeFromMap(String value) {
    switch (value) {
      case 'novel':
        return BookType.novel;
      case 'manga':
        return BookType.manga;
    }
  }

  static bookStatusFromMap(String value) {
    switch (value) {
      case 'ongoing':
        return BookStatus.ongoing;
      case 'completed':
        return BookStatus.completed;
    }
  }

  @override
  String toString() {
    return 'Book(name: $name, source: $source, type: $type)';
  }

  Book copyWith({
    int? chapterCount,
    List<Chapter>? chapters,
    ShenImage? coverPicture,
    String? description,
    String? id,
    String? link,
    String? name,
    String? rating,
    String? source,
    BookStatus? status,
    BookType? type,
  }) {
    return Book(
      chapterCount: chapterCount ?? this.chapterCount,
      chapters: chapters ?? this.chapters,
      coverPicture: coverPicture ?? this.coverPicture,
      description: description ?? this.description,
      id: id ?? this.id,
      link: link ?? this.link,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      source: source ?? this.source,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [id];
}

enum BookType { novel, manga }

enum BookStatus { ongoing, completed }

extension EnumSerialisation on BookType {
  String toMap() {
    switch (this) {
      case BookType.manga:
        return 'manga';
      case BookType.novel:
        return 'novel';
    }
  }
}

extension BookStatusSerialisation on BookStatus {
  String toMap() {
    switch (this) {
      case BookStatus.ongoing:
        return 'ongoing';
      case BookStatus.completed:
        return 'completed';
    }
  }
}
