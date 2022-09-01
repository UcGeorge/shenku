import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/storage_cubit.dart';
import '../../logic/services/general.dart';
import '../widgets/book_section/book_section.dart';
import '../widgets/shen_scaffold/shen_scaffold.dart';
import '../widgets/smooth_scroll/smooth_scroll.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key, this.startExpanded}) : super(key: key);

  final ScrollController controller = ScrollController();
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: startExpanded,
      body: BlocBuilder<StorageCubit, StorageState>(
        builder: (context, state) {
          return SmoothScrollView(
            controller: controller,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                BookSection(
                  title: 'Library',
                  books: state.appData.library,
                  overrideSeeAll: doNothing,
                  cap: state.appData.library.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
