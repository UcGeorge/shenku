import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/color.dart';
import '../../../constants/svg.dart';
import '../../../logic/cubit/navigator_cubit.dart';
import '../../../logic/services/general.dart';
import '../logo/shen_ku_logo.dart';
import 'drawer_tile.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool expanded = false;
  String hovered = 'null';

  void _setHovered(String hover) {
    setState(() {
      hovered = hover;
    });
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
    return MouseRegion(
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
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                _buildLogo(),
                _buildDivider(),
                Center(
                  child: AppDrawerTile(
                    title: "Home",
                    expanded: expanded,
                    onTap: doNothing,
                    selected: false,
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
                    onTap: doNothing,
                    selected: true,
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
                    onTap: doNothing,
                    selected: false,
                    hovered: hovered == "Library",
                    setHoverState: (value) => _setHovered(value),
                    iconPath: bookmarkSvg,
                    selectedIconPath: bookmarkBoldSvg,
                  ),
                ),
                // Center(
                //   child: MouseRegion(
                //     cursor: SystemMouseCursors.click,
                //     onEnter: (e) => _setHovered('Search'),
                //     onExit: (e) => _setHovered('null'),
                //     child: GestureDetector(
                //       onTap: () {
                //         // if (selected != "Search") {
                //         //   context.read<SelectedMenu>().select("Search");
                //         // }
                //       },
                //       child: Container(
                //         height: 36,
                //         width: 188,
                //         decoration: BoxDecoration(
                //           // color: selected == "Search" ? Color(0xFF282828) : null,
                //           borderRadius: BorderRadius.circular(4),
                //         ),
                //         child: Center(
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               const Icon(
                //                 Icons.search_rounded,
                //                 size: 16,
                //                 // color: selected == "Search"
                //                 //     ? Colors.white
                //                 //     : (hovered == 'Search'
                //                 //         ? Colors.white.withOpacity(0.8)
                //                 //         : Colors.white.withOpacity(0.5)),
                //               ),
                //               const SizedBox(
                //                 width: 16.7,
                //               ),
                //               Text(
                //                 "Search",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headline2!
                //                     .copyWith(
                //                       fontSize: 16,
                //                       letterSpacing: 1,
                //                       // color: selected == "Search"
                //                       //     ? Colors.white
                //                       //     : (hovered == 'Search'
                //                       //         ? Colors.white.withOpacity(0.8)
                //                       //         : Colors.white.withOpacity(0.5)),
                //                     ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: MouseRegion(
                //     cursor: SystemMouseCursors.click,
                //     onEnter: (e) => _setHovered('Library'),
                //     onExit: (e) => _setHovered('null'),
                //     child: GestureDetector(
                //       onTap: () {
                //         // if (selected != "Library") {
                //         //   context.read<SelectedMenu>().select("Library");
                //         // }
                //       },
                //       child: Container(
                //         height: 36,
                //         width: 188,
                //         decoration: BoxDecoration(
                //           // color: selected == "Library" ? Color(0xFF282828) : null,
                //           borderRadius: BorderRadius.circular(4),
                //         ),
                //         child: Center(
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               const Icon(
                //                 Icons.menu_book,
                //                 size: 16,
                //                 // color: selected == "Library"
                //                 //     ? Colors.white
                //                 //     : (hovered == 'Library'
                //                 //         ? Colors.white.withOpacity(0.8)
                //                 //         : Colors.white.withOpacity(0.5)),
                //               ),
                //               const SizedBox(
                //                 width: 16.7,
                //               ),
                //               Text(
                //                 "Library",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headline2!
                //                     .copyWith(
                //                       fontSize: 16,
                //                       letterSpacing: 1,
                //                       // color: selected == "Library"
                //                       //     ? Colors.white
                //                       //     : (hovered == 'Library'
                //                       //         ? Colors.white.withOpacity(0.8)
                //                       //         : Colors.white.withOpacity(0.5)),
                //                     ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                _buildDivider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
