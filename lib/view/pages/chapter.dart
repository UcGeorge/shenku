import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants/color.dart';
import '../../constants/fonts.dart';
import '../../data/models/book.dart';
import '../../logic/cubit/reading_cubit.dart';
import '../../logic/cubit/status_bar_cubit.dart';
import '../../logic/services/general.dart';
import '../widgets/chapter_view/chapter_header.dart';
import '../widgets/image/multi_source_image.dart';
import '../widgets/shen_scaffold/window_buttons.dart';
import '../widgets/status_bar/shen_status_bar.dart';

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
    return state.chapter!.hasContent(state.book!.type)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 4,
                      width: 200,
                      decoration: BoxDecoration(
                        color: white.withOpacity(.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: (loadedUnits.length /
                              state.chapter!.contentLength(state.book!.type)) *
                          200,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  '${loadedUnits.length} / ${state.chapter!.contentLength(state.book!.type)}',
                  overflow: TextOverflow.ellipsis,
                  style: nunito.copyWith(
                    fontSize: 11,
                    color: white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildChapterContent(BuildContext context, ReadingState state) {
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
                            source: state.chapter!.chapterImages![i].source,
                            url: state.chapter!.chapterImages![i].url,
                            radius: 20,
                            backgroundColor: dark,
                            referer: state.chapter!.link,
                            fit: BoxFit.fitWidth,
                            useOriginalSize: true,
                            onLoadComplete: () {
                              loadedUnits.add(i);
                              context.statusBar.update(
                                'chapter-load-progress',
                                _buildProgressWidget(context, state),
                              );
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
              ],
            ),
          ),
        );
      },
    );
  }
}
