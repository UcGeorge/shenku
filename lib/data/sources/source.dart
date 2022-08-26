import 'dart:async';

import 'package:shenku/data/models/book.dart';
import 'package:shenku/data/models/chapter.dart';

abstract class BookSource {
  FutureOr<List<Book>> getHomePage();
  FutureOr<List<Book>> search(String term);
  FutureOr<Book> getBookDetails(String bookSource);
  FutureOr<Chapter> getBookChapterDetails(String chapterSource);
}

extension Iterator<T> on List<T> {
  void iterate(Function(T element, int index) iterator) {
    for (int i = 0; i < length; i++) {
      iterator(this[i], i);
    }
  }
}
