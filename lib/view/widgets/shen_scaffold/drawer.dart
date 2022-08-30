import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/color.dart';
import '../../../constants/svg.dart';
import '../../../logic/cubit/navigator_cubit.dart';
import '../logo/shen_ku_logo.dart';
import 'drawer_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, this.startExpanded}) : super(key: key);

  final bool? startExpanded;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool expanded;
  String hovered = 'null';

  void _setHovered(String hover) {
    setState(() {
      hovered = hover;
    });
  }

  @override
  void initState() {
    super.initState();
    expanded = widget.startExpanded ?? false;
  }

  AnimatedCrossFade _buildLogo() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 100),
      firstChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            const ShenKuLogo(18),
            const SizedBox(width: 10),
            SvgPicture.asset(
              shenKuSvg,
              height: 22,
              color: thisWhite,
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_backspace_rounded,
              color: lessWhite,
            ),
          ],
        ),
      ),
      secondChild: const ShenKuLogo(18),
      crossFadeState:
          expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Divider(
        color: white.withOpacity(.15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MouseRegion(
        // cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() {
          expanded = true;
        }),
        onExit: (e) => setState(() {
          expanded = false;
        }),
        child: AnimatedContainer(
          height: double.infinity,
          width: expanded ? 260.0 : 92,
          duration: const Duration(milliseconds: 100),
          decoration: const BoxDecoration(
            color: dark,
          ),
          child: BlocBuilder<NavigationCubit, NavigatonState>(
            builder: (_, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  _buildDivider(),
                  Center(
                    child: AppDrawerTile(
                      title: "Home",
                      expanded: expanded,
                      onTap: () => context.navigator.goToHome(context, true),
                      selected: state.route == 'Home',
                      hovered: hovered == "Home",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: homeSvg,
                      selectedIconPath: homeBoldSvg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: AppDrawerTile(
                      title: "Explore",
                      expanded: expanded,
                      onTap: () => context.navigator.goToExplore(context, true),
                      selected: state.route == 'Explore',
                      hovered: hovered == "Explore",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: searchSvg,
                      selectedIconPath: searchBoldSvg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: AppDrawerTile(
                      title: "Library",
                      expanded: expanded,
                      onTap: () => context.navigator.goToLibrary(context, true),
                      selected: state.route == 'Library',
                      hovered: hovered == "Library",
                      setHoverState: (value) => _setHovered(value),
                      iconPath: bookmarkSvg,
                      selectedIconPath: bookmarkBoldSvg,
                    ),
                  ),
                  _buildDivider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
