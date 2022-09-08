import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logging/logging.dart';

import '../../constants/color.dart';
import '../../constants/fonts.dart';
import '../../data/models/book.dart';
import '../../logic/cubit/reading_cubit.dart';
import '../../logic/cubit/status_bar_cubit.dart';
import '../../logic/services/general.dart';
import '../widgets/chapter_view/chapter_header.dart';
import '../widgets/chapter_view/nav_buttons.dart';
import '../widgets/image/multi_source_image.dart';
import '../widgets/shen_scaffold/window_buttons.dart';
import '../widgets/status_bar/shen_status_bar.dart';

final _log = Logger('chapter_view');

class ChapterView extends StatefulWidget {
  const ChapterView({Key? key}) : super(key: key);

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  Set<int> loadedUnits = {};

  WindowTitleBarBox _buildAppTitleBar(ReadingState state) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(
              child: ChapterHeader(
                book: state.book!,
                chapter: state.chapter!,
              ),
            ),
          ),
          const WindowButtons()
        ],
      ),
    );
  }

  Widget _buildProgressWidget(BuildContext context, ReadingState state) {
    final isComplete =
        loadedUnits.length == state.chapter!.contentLength(state.book!.type);
    return state.chapter!.hasContent(state.book!.type)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isComplete)
                  Text(
                    '${loadedUnits.length} / ${state.chapter!.contentLength(state.book!.type)}',
                    overflow: TextOverflow.ellipsis,
                    style: nunito.copyWith(
                      fontSize: 11,
                      color: white,
                      letterSpacing: 1.5,
                    ),
                  ),
                const SizedBox(width: 8),
                isComplete
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 16,
                      )
                    : const CupertinoActivityIndicator(radius: 8),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildChapterContent(BuildContext context, ReadingState state_) {
    final state = state_;
    context.statusBar.addrItem(
      'chapter-load-progress',
      _buildProgressWidget(context, state),
    );

    return state.chapter!.hasContent(state.book!.type)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize(context).width >= 802
                    ? 800
                    : screenSize(context).width - 2,
                color: dark,
                child: ListView.builder(
                  // shrinkWrap: true,
                  controller: context.reader.scrollController,
                  cacheExtent: 999999999999999,
                  itemCount: state.chapter!.contentLength(state.book!.type),
                  itemBuilder: (_, i) {
                    var type = state.book!.type;
                    return type == BookType.novel
                        ? Container(
                            height: 20,
                            color: Colors.red,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: .5,
                            ),
                          )
                        : MultiSourceImage(
                            shouldRetry: true,
                            source: state.chapter!.chapterImages![i].source,
                            url: state.chapter!.chapterImages![i].url,
                            radius: 20,
                            backgroundColor: dark,
                            referer: state.chapter!.link,
                            fit: BoxFit.fitWidth,
                            useOriginalSize: true,
                            onLoadComplete: () {
                              final localChapterId = state.chapterId;
                              final remoteChapterId =
                                  context.reader.state.chapterId;
                              // _log.info('$localChapterId || $remoteChapterId');
                              if (localChapterId == remoteChapterId) {
                                loadedUnits.add(i);
                                context.statusBar.update(
                                  'chapter-load-progress',
                                  _buildProgressWidget(context, state),
                                );
                              }
                            },
                          );
                  },
                ),
              ),
            ],
          )
        : const Center(
            child: SpinKitSpinningLines(
              color: violet,
              size: 50,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    context.reader.getChapterDetails(context);
    return BlocBuilder<ReadingCubit, ReadingState>(
      builder: (context, state) {
        return WindowBorder(
          color: Colors.black,
          child: Material(
            color: Colors.black,
            child: Stack(
              children: [
                SizedBox(
                  height: screenSize(context).height,
                  child: Column(
                    children: [
                      Expanded(child: _buildChapterContent(context, state)),
                      const ShenStatusBar(),
                    ],
                  ),
                ),
                _buildAppTitleBar(state),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ChapterNavButtons(
                      book: state.book!,
                      chapter: state.chapter!,
                      chapterScrollController: context.reader.scrollController,
                      onTap: (callback) {
                        setState(() => loadedUnits.clear());
                        context.reader.scrollController.jumpTo(0);
                        context.statusBar.removerItem('chapter-load-progress');
                        callback.call();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
