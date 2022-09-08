import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import '../../../logic/cubit/reading_cubit.dart';
import 'nav_button/shen_nav_button.dart';

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
  final Function(VoidCallback) onTap;

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

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toInt().toString(),
            overflow: TextOverflow.ellipsis,
            style: nunito.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Slider(
            value: value.toDouble(),
            min: 0,
            max: chapterLength.toDouble(),
            onChanged: (value) {
              final controller = widget.chapterScrollController;
              controller.jumpTo((value / chapterLength) *
                  controller.position.maxScrollExtent);
            },
            thumbColor: violet,
            activeColor: violet.withOpacity(.3),
            inactiveColor: white.withOpacity(.3),
          ),
          Text(
            '$chapterLength',
            overflow: TextOverflow.ellipsis,
            style: nunito.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
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
              _buildChapterSlider(),
              ShenChapterNavButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
