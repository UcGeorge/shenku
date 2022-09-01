import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/color.dart';
import '../../../constants/fonts.dart';
import '../../../data/models/book.dart';
import '../../../logic/cubit/book_details_cubit.dart';
import '../image/multi_source_image.dart';
import '../smooth_scroll/smooth_scroll.dart';
import 'chapter_tile/chapter_tile.dart';
import 'close_button.dart';
import 'context_buttons.dart';
import 'rating_star.dart';

class BookDetailsView extends StatelessWidget {
  BookDetailsView({Key? key}) : super(key: key);

  final ScrollController controller = ScrollController();

  Widget _buildCoverPhoto(BookDetailsState state) {
    return state.book!.coverPicture == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 200,
                width: 200,
                child: MultiSourceImage(
                  radius: 100,
                  source: state.book!.coverPicture!.source,
                  url: state.book!.coverPicture!.url,
                  backgroundColor: thisWhite.withOpacity(.15),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  Expanded _buildName(BuildContext context, BookDetailsState state) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.book!.name,
            maxLines: 3,
            overflow: TextOverflow.fade,
            style: nunito.copyWith(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildChapterCount(state, context),
          const SizedBox(height: 5),
          Table(
            columnWidths: const {0: FixedColumnWidth(50)},
            children: [
              _tr_source(context, state),
              if (state.book!.status != null) _tr_status(context, state),
              if (state.book!.rating != null) _tr_rating(context, state)
            ],
          ),
          const SizedBox(height: 5),
          DetailsViewContextButtons(
            state,
            context: context,
          )
        ],
      ),
    );
  }

  TableRow _tr_rating(BuildContext context, BookDetailsState state) {
    return TableRow(
      children: [
        Text(
          'Rating',
          style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: 11,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 1),
        ),
        RatingStar(double.parse(
          state.book!.rating ?? '',
          (source) => 0,
        )),
      ],
    );
  }

  TableRow _tr_status(BuildContext context, BookDetailsState state) {
    return TableRow(
      children: [
        Text(
          'Status',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 11,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1,
              ),
        ),
        Text(
          state.book!.status == BookStatus.completed ? 'Completed' : 'Ongoing',
          style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
              letterSpacing: 1),
        ),
      ],
    );
  }

  TableRow _tr_source(BuildContext context, BookDetailsState state) {
    return TableRow(
      children: [
        Text(
          'Source',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 11,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1,
              ),
        ),
        Text(
          state.book!.source,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 11,
                color: blueGrey,
                letterSpacing: 1,
              ),
        ),
      ],
    );
  }

  Text _buildChapterCount(BookDetailsState state, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: state.book!.type == BookType.novel ? 'NOVEL' : 'MANGA',
        children: [
          if (state.book!.chapterCount != null)
            TextSpan(
              text: '  •  ${state.book!.chapterCount!} CHAPTERS',
            ),
        ],
      ),
      style: Theme.of(context).textTheme.headline2!.copyWith(
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 1,
          ),
    );
  }

  List<Widget> _buildDescription(
    BuildContext context,
    BookDetailsState state,
  ) =>
      state.book!.description == null
          ? []
          : [
              Text(
                'DESCRIPTION',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 1,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                state.book!.description ?? '',
                style: nunito.copyWith(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 20),
            ];

  Expanded _buildChapterList(BuildContext context, BookDetailsState state) {
    return Expanded(
      child: SmoothScrollView(
        controller: controller,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            ..._buildDescription(context, state),
            ...__buildChapterList(context, state),
          ],
        ),
      ),
    );
  }

  List<Widget> __buildChapterList(
    BuildContext context,
    BookDetailsState state,
  ) =>
      state.book!.chapters == null
          ? []
          : [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Text(
                  'CHAPTERS',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 1,
                      ),
                ),
              ),
              ...state.book!.chapters!.map((e) => ChapterItem(e, state.book!)),
            ];

  @override
  Widget build(BuildContext context) {
    context.detailsController.getBookDetails(context);
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DVCloseButton(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildCoverPhoto(state),
                  _buildName(context, state),
                ],
              ),
            ),
            _buildChapterList(context, state),
          ],
        );
      },
    );
  }
}
