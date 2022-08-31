import 'package:flutter/material.dart';
import 'package:shenku/view/widgets/shen_scaffold/shen_scaffold.dart';

import '../../data/models/book.dart';
import '../widgets/book_section/book_section.dart';
import '../widgets/smooth_scroll/smooth_scroll.dart';

class SeeAllPage extends StatelessWidget {
  SeeAllPage({
    Key? key,
    required this.books,
    required this.title,
  }) : super(key: key);

  final List<Book> books;
  final String title;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      body: SmoothScrollView(
        controller: controller,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            BookSection(
              title: title,
              books: books,
              cap: books.length,
            ),
          ],
        ),
      ),
    );
  }
}
