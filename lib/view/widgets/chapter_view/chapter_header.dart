import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import '../../../logic/cubit/reading_cubit.dart';
import '../../../logic/cubit/status_bar_cubit.dart';
import '../../../logic/cubit/storage_cubit.dart';
import 'close_button.dart';

class ChapterHeader extends StatefulWidget {
  const ChapterHeader({
    Key? key,
    required this.book,
    required this.chapter,
  }) : super(key: key);

  final Book book;
  final Chapter chapter;

  @override
  State<ChapterHeader> createState() => _ChapterHeaderState();
}

class _ChapterHeaderState extends State<ChapterHeader> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  void syncReadingData() {
    final controller = context.reader.scrollController;
    final chapterLength = widget.chapter.contentLength(widget.book.type);
    final value = controller.hasClients &&
            controller.position.haveDimensions &&
            controller.position.maxScrollExtent != 0
        ? (controller.offset / controller.position.maxScrollExtent) *
            chapterLength
        : 0;
    if (value.toInt() != chapterLength && value.toInt() != 0) {
      context.storageCubit.addToHistory(
        bookId: widget.book.id,
        chapterId: widget.chapter.id,
        pageNumber: value.toInt(),
        position: controller.offset,
      );
    } else {
      context.storageCubit.removeFromHistory(
        bookId: widget.book.id,
        chapterId: widget.chapter.id,
      );
    }
    context.statusBar.removerItem('chapter-load-progress');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isHovering ? 1 : .15,
        child: Container(
          height: 20,
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: blueGrey,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              ChapterCloseButton(
                onTap: () => Future.delayed(
                  const Duration(milliseconds: 0),
                  syncReadingData,
                ),
                enabled: true,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${widget.book.name} / ${widget.chapter.name}',
                  overflow: TextOverflow.ellipsis,
                  style: nunito.copyWith(
                      fontSize: 11,
                      color: isHovering
                          ? Colors.white.withOpacity(0.8)
                          : Colors.white.withOpacity(0.5),
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
