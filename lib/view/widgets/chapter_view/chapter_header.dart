import 'package:flutter/material.dart';
import 'package:shenku/constants/fonts.dart';
import 'package:shenku/data/models/chapter.dart';
import 'package:shenku/logic/cubit/status_bar_cubit.dart';

import '../../../constants/color.dart';
import '../../../data/models/book.dart';
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
                  () {
                    //TODO: Save state of books in library
                    context.statusBar.removerItem('chapter-load-progress');
                  },
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
