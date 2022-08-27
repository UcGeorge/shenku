import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shenku/data/sources/source.dart';
import 'package:shenku/view/widgets/book_section/book_section.dart';

import '../../logic/cubit/homepage_cubit.dart';
import '../widgets/shen_scaffold/shen_scaffold.dart';
import '../widgets/smooth_scroll/smooth_scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomepageCubit>().getHomepageFromSources();
  }

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      body: BlocBuilder<HomepageCubit, HomepageState>(
        builder: (context, state) {
          final bookSectionTitles = state.sourcesHomepage.keys.toList();
          final bookSectionBooks = state.sourcesHomepage.values.toList();

          List bookSections = [];

          bookSectionTitles.iterate(
            (element, index) {
              bookSections.add(BookSection(
                books: bookSectionBooks[index],
                title: element,
              ));
            },
          );

          return SmoothScrollView(
            controller: controller,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                BookSection(
                  title: 'Library',
                  books: state.library,
                ),
                ...bookSections,
              ],
            ),
          );
        },
      ),
    );
  }
}
