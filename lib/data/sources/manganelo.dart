import 'package:logging/logging.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../logic/services/hash.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../models/shen_image.dart';
import 'source.dart';

final _log = Logger('manganelo');

class Manganelo extends BookSource {
  Manganelo() : super('Manganelo');

  final String domain = "https://manganato.com";
  final String homePageEndpoint = "/genre-all?type=topview";
  final String homePageItem = ".content-genres-item";
  final String homePageItemCoverImage = ".content-genres-item a img";
  final String homePageItemTitle = ".content-genres-item h3 a";
  final String homePageItemRating =
      ".content-genres-item a em.genres-item-rate";

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

        webScraper.getElement(homePageItemCoverImage, []).iterate((e, i) {
          var rating = e['title'];
          result[i] = result[i].copyWith(rating: rating);
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
  Future<List<Book>> search(String term) async {
    // TODO: implement search
    throw UnimplementedError();
  }
}
