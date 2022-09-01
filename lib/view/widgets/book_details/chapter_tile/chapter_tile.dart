import 'package:flutter/material.dart';

import '../../../../data/models/book.dart';
import '../../../../data/models/chapter.dart';
import '../../../../logic/cubit/navigator_cubit.dart';
import '../../../../logic/cubit/reading_cubit.dart';
import '../../../pages/chapter.dart';

class ChapterItem extends StatefulWidget {
  const ChapterItem(this.chapter, this.book, {Key? key}) : super(key: key);

  final Book book;
  final Chapter chapter;

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isHovering = false;

  void showChapter(BuildContext context) {
    context.reader.readChapter(widget.book, widget.chapter.id);
    context.navigator.goToCustomScaffold(
      context,
      scaffold: ChapterView(),
    );
  }

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showChapter(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: _toogleHover,
        onExit: _toogleHover,
        child: Container(
          color: isHovering ? Colors.white.withOpacity(0.05) : null,
          child: Column(
            children: [
              Divider(
                color: Colors.white.withOpacity(0.5),
                height: 1,
                thickness: 0.5,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      widget.chapter.name,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
