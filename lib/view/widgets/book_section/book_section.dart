import 'package:flutter/material.dart';
import 'package:shenku/constants/color.dart';
import 'package:shenku/constants/fonts.dart';

import '../../../data/models/book.dart';
import '../../../logic/services/general.dart';
import 'book_tile.dart';
import 'read_more.dart';

class BookSection extends StatelessWidget {
  const BookSection({
    Key? key,
    required this.books,
    required this.title,
  }) : super(key: key);

  final List<Book>? books;
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "$title: ${books?.length} books";
  }

  Row _buildSectionTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: nunito.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        if (books == null)
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: violet,
            ),
          ),
        const Spacer(),
        (books?.length ?? 0) > 10
            ? const SeeMoreButton(seeMore: doNothing)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildNovels(BuildContext context, int i) {
    return BookTile(
      book: books![i],
    );
  }

  @override
  Widget build(BuildContext context) {
    return books == null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildSectionTitle(context),
          )
        : books!.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(context),
                    const SizedBox(height: 15),
                    books == null
                        ? const SizedBox.shrink()
                        : Wrap(
                            runSpacing: 15,
                            spacing: 15,
                            children: [
                              for (int i = 0;
                                  i <
                                      ((books!.length) <= 10
                                          ? (books!.length)
                                          : 10);
                                  i++)
                                _buildNovels(context, i)
                            ],
                          ),
                  ],
                ),
              );
  }
}
