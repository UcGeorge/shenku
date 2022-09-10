import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import '../../../logic/cubit/reading_cubit.dart';
import '../../../logic/cubit/storage_cubit.dart';
import 'nav_button/shen_nav_button.dart';
import 'slider/slider.dart';

class ChapterNavButtons extends StatefulWidget {
  const ChapterNavButtons({
    Key? key,
    required this.book,
    required this.chapter,
    required this.onTap,
    required this.chapterScrollController,
  }) : super(key: key);

  final Book book;
  final Chapter chapter;
  final ScrollController chapterScrollController;
  final Function(Future<dynamic> Function()) onTap;

  @override
  State<ChapterNavButtons> createState() => _ChapterNavButtonsState();
}

class _ChapterNavButtonsState extends State<ChapterNavButtons> {
  bool isHovering = false;

  @override
  void dispose() {
    super.dispose();
    widget.chapterScrollController.removeListener(updateState);
  }

  @override
  void initState() {
    super.initState();
    widget.chapterScrollController.addListener(updateState);
  }

  void updateState() => setState(() {});

  void _toogleHover(bool value) {
    setState(() {
      isHovering = value;
    });
  }

  Container _buildChapterSlider() {
    final controller = widget.chapterScrollController;
    final chapterLength = widget.chapter.contentLength(widget.book.type);
    final value = controller.hasClients &&
            controller.position.haveDimensions &&
            controller.position.maxScrollExtent != 0
        ? (controller.offset / controller.position.maxScrollExtent) *
            chapterLength
        : 0;
    return Container(
      height: 40,
      // width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ChapterSlider(
        value: value,
        chapterLength: chapterLength,
        widget: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _toogleHover(true),
      onExit: (_) => _toogleHover(false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isHovering ? 1 : .15,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShenChapterNavButton(
                forward: false,
                enabled: widget.book.chapters!.last != widget.chapter,
                onTap: () => widget.onTap(() async {
                  final nextChapterId = widget
                      .book
                      .chapters![
                          widget.book.chapters!.indexOf(widget.chapter) + 1]
                      .id;
                  await context.storageCubit.removeFromHistory(
                    bookId: widget.book.id,
                    chapterId: widget.chapter.id,
                    addChapterId: nextChapterId,
                  );
                  context.reader.readChapter(
                    widget.book,
                    nextChapterId,
                  );
                }),
              ),
              _buildChapterSlider(),
              ShenChapterNavButton(
                forward: true,
                enabled: widget.book.chapters!.first != widget.chapter,
                onTap: () => widget.onTap(() async {
                  final nextChapterId = widget
                      .book
                      .chapters![
                          widget.book.chapters!.indexOf(widget.chapter) - 1]
                      .id;
                  await context.storageCubit.removeFromHistory(
                    bookId: widget.book.id,
                    chapterId: widget.chapter.id,
                    addChapterId: nextChapterId,
                  );
                  context.reader.readChapter(
                    widget.book,
                    nextChapterId,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
