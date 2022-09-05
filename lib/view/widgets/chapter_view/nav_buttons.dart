import 'package:flutter/material.dart';
import 'package:shenku/logic/cubit/reading_cubit.dart';

import '../../../constants/color.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import 'nav_button/shen_nav_button.dart';

class ChapterNavButtons extends StatefulWidget {
  const ChapterNavButtons({
    Key? key,
    required this.book,
    required this.chapter,
    required this.onTap,
  }) : super(key: key);

  final Book book;
  final Chapter chapter;
  final Function(VoidCallback) onTap;

  @override
  State<ChapterNavButtons> createState() => _ChapterNavButtonsState();
}

class _ChapterNavButtonsState extends State<ChapterNavButtons> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isHovering ? .7 : .15,
        child: Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
            color: blueGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ShenChapterNavButton(
                  forward: false,
                  enabled: widget.book.chapters!.last != widget.chapter,
                  onTap: () => widget.onTap(() {
                    context.reader.readChapter(
                      widget.book,
                      widget
                          .book
                          .chapters![
                              widget.book.chapters!.indexOf(widget.chapter) + 1]
                          .id,
                    );
                  }),
                ),
              ),
              VerticalDivider(
                color: white.withOpacity(.3),
                width: 0,
              ),
              Expanded(
                child: ShenChapterNavButton(
                  forward: true,
                  enabled: widget.book.chapters!.first != widget.chapter,
                  onTap: () => widget.onTap(() {
                    context.reader.readChapter(
                      widget.book,
                      widget
                          .book
                          .chapters![
                              widget.book.chapters!.indexOf(widget.chapter) - 1]
                          .id,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
