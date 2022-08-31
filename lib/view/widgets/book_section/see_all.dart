import 'package:flutter/material.dart';
import 'package:shenku/data/models/book.dart';

import '../../../logic/cubit/navigator_cubit.dart';
import '../../pages/see_all.dart';

class SeeMoreButton extends StatefulWidget {
  const SeeMoreButton({
    Key? key,
    required this.seeMore,
    required this.books,
    required this.title,
    this.overrideSeeAll,
  }) : super(key: key);

  final VoidCallback? overrideSeeAll;
  final VoidCallback seeMore;
  final List<Book> books;
  final String title;

  @override
  State<SeeMoreButton> createState() => _SeeMoreButtonState();
}

class _SeeMoreButtonState extends State<SeeMoreButton> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.seeMore,
      child: MouseRegion(
        onEnter: _toogleHover,
        onExit: _toogleHover,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.overrideSeeAll ??
              () => context.navigator.goForwardWithoutState(
                    context,
                    SeeAllPage(
                      books: widget.books,
                      title:
                          '${context.navigator.state.route} / ${widget.title}',
                    ),
                    '${context.navigator.state.route} / ${widget.title}',
                  ),
          child: Text(
            'SEE ALL',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 12,
                  color: isHovering
                      ? Colors.white.withOpacity(0.8)
                      : Colors.white.withOpacity(0.5),
                  letterSpacing: 1.5,
                ),
          ),
        ),
      ),
    );
  }
}
