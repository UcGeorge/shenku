import 'package:logging/logging.dart';
import 'package:shenku/data/models/shen_image.dart';
import 'package:shenku/logic/services/hash.dart';
import 'package:web_scraper/web_scraper.dart';

import '../models/book.dart';
import '../models/chapter.dart';
import 'source.dart';

final _log = Logger('manganelo');

class Manganelo implements BookSource {
  final String domain = "https://manganato.com";
  final String homePageEndpoint = "/genre-all?type=topview";
  final String homePageItem = ".content-genres-item";
  final String homePageItemTitle = ".content-genres-item h3 a";
  final String homePageItemCoverImage = ".content-genres-item a img";

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
  Future<List<Book>> getHomePage() async {
    List<Book> result = [];
    _log.info('Getting homepage');
    final webScraper = WebScraper(domain);

    try {
      if (await webScraper.loadWebPage(homePageEndpoint)) {
        webScraper.getElement(homePageItemTitle, ['href']).forEach((e) {
          var title = e['title'];
          var href = e['attributes']['href'];
          result.add(Book(
            id: hash(domain + title),
            name: title,
            type: BookType.manga,
            link: href,
            source: 'Manganelo',
          ));
        });

        webScraper.getElement(homePageItemCoverImage, ['src']).iterate((e, i) {
          var src = e['attributes']['src'];
          result[i] = result[i].copyWith(coverPicture: ShenImage(src));
        });

        return result;
      } else {
        throw Exception('Unable to get homepage');
      }
    } on Exception catch (e) {
      _log.warning(e);
      return result;
    }
  }

  @override
  List<Book> search(String term) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
