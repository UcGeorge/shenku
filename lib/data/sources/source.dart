import 'package:shenku/data/models/book.dart';
import 'package:shenku/data/models/chapter.dart';

abstract class BookSource {
  List<Book> getHomePage();
  List<Book> search(String term);
  Book getBookDetails(String bookSource);
  Chapter getBookChapterDetails(String chapterSource);
}
