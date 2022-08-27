import '../models/book.dart';
import '../models/chapter.dart';
import 'source.dart';

class WuxiaWorld extends BookSource {
  WuxiaWorld() : super('Wuxia World');

  @override
  Future<Chapter> getBookChapterDetails(String chapterSource) async {
    // TODO: implement getBookChapterDetails
    throw UnimplementedError();
  }

  @override
  Future<Book> getBookDetails(String bookSource) async {
    // TODO: implement getBookDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getHomePage() async {
    await Future.delayed(const Duration(seconds: 5));
    return [];
  }

  @override
  Future<List<Book>> search(String term) async {
    // TODO: implement search
    throw UnimplementedError();
  }
}
