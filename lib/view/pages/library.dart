import 'package:flutter/material.dart';

import '../widgets/shen_scaffold/shen_scaffold.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key, this.startExpanded}) : super(key: key);
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: startExpanded,
      body: Container(),
    );
  }
}
