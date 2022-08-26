import 'package:shenku/data/models/chapter.dart';
import 'package:shenku/data/models/book.dart';
import 'package:shenku/data/sources/source.dart';

class Manganelo implements BookSource {
  @override
  Chapter getBookChapterDetails(String chapterSource) {
    // TODO: implement getBookChapterDetails
    throw UnimplementedError();
  }

  @override
  Book getBookDetails(String bookSource) {
    // TODO: implement getBookDetails
    throw UnimplementedError();
  }

  @override
  List<Book> getHomePage() {
    // TODO: implement getHomePage
    throw UnimplementedError();
  }

  @override
  List<Book> search(String term) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
