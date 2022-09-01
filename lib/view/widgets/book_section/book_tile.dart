import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/book.dart';
import '../../../data/models/shen_image.dart';
import '../../../logic/cubit/book_details_cubit.dart';
import 'book_tile/context_button.dart';

class BookTile extends StatefulWidget {
  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  ClipRRect _buildCoverPicture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: widget.book.coverPicture != null
          ? SizedBox(
              height: 118,
              width: 118,
              child: widget.book.coverPicture!.source == ImageSource.network
                  ? Image.network(
                      widget.book.coverPicture!.url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, o, s) => Container(
                        height: 118,
                        width: 118,
                        decoration: const BoxDecoration(
                          color: blueGrey,
                        ),
                      ),
                    )
                  : Image.file(
                      File(widget.book.coverPicture!.url),
                      errorBuilder: (context, o, s) => Container(
                        height: 118,
                        width: 118,
                        decoration: const BoxDecoration(
                          color: blueGrey,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
            )
          : const SizedBox(
              height: 118,
              width: 118,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: GestureDetector(
        onTap: () => context.detailsController.showDetails(widget.book),
        child: SizedBox(
          width: 146,
          height: 212,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                decoration: BoxDecoration(
                  color: dark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoverPicture(),
                    const SizedBox(height: 8),
                    Text(
                      widget.book.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: nunito.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.book.type == BookType.manga ? 'Manga' : 'Novel',
                      style: nunito.copyWith(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
              ),
              isHovering
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: BookTileContextButton(widget.book, context),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
