import 'dart:async';

import '../models/book.dart';
import '../models/chapter.dart';

abstract class BookSource {
  BookSource(this.name);

  final String name;

  Future<List<Book>> getHomePage();

  Future<List<Book>> search(String term);

  Future<Book> getBookDetails(Book book, {required List<String> fields});

  Future<Chapter> getBookChapterDetails(String chapterSource);
}

extension Iterator<T> on List<T> {
  void iterate(Function(T element, int index) iterator) {
    for (int i = 0; i < length; i++) {
      iterator(this[i], i);
    }
  }
}
