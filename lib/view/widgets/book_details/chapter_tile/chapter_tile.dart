import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/book.dart';
import '../../../../data/models/chapter.dart';
import '../../../../logic/cubit/navigator_cubit.dart';
import '../../../../logic/cubit/reading_cubit.dart';
import '../../../../logic/cubit/storage_cubit.dart';
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
      scaffold: const ChapterView(),
    );
  }

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageCubit, StorageState>(builder: (_, state) {
      return GestureDetector(
        onTap: () => showChapter(context),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: _toogleHover,
          onExit: _toogleHover,
          child: Container(
            color: isHovering ? Colors.white.withOpacity(0.05) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.white.withOpacity(0.5),
                  height: 1,
                  thickness: 0.5,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        widget.chapter.name,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1,
                            ),
                      ),
                      const SizedBox(width: 5),
                      if (state.appData.history.containsKey(widget.book.id) &&
                          state.appData.history[widget.book.id]!.chapterHistory
                              .containsKey(widget.chapter.id))
                        Text(
                          '• Page ${state.appData.history[widget.book.id]!.chapterHistory[widget.chapter.id]!.pageNumber}',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 11,
                                    color: Colors.white.withOpacity(0.3),
                                    letterSpacing: 1,
                                  ),
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
    });
  }
}
