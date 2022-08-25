import 'package:flutter/material.dart';
import 'package:shenku/logic/cubit/storage_cubit.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    context.storageCubit.initializeDirectory(onComplete: onInitComplete);
  }

  void onInitComplete(bool success, String? error) {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
