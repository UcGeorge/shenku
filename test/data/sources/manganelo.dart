import 'package:shenku/data/sources/manganelo.dart';

void main() async {
  final Manganelo manganelo = Manganelo();
  final homepageBooks = await manganelo.getHomePage();
  print('Missing Fields: ${homepageBooks.first.missingFields}');
  final lastChapter = (await manganelo.getBookDetails(
    homepageBooks.first,
    fields: homepageBooks.first.missingFields,
  ))
      .chapters!
      .first;
  print(await manganelo.getBookChapterDetails(lastChapter));
}
