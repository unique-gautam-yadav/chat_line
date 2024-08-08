// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:chatline_demo/common/style/app_colors.dart';
import 'package:chatline_demo/features/inbox/screens/inbox_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selected = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const InboxScreen(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              onItemTap: (_) {
                setState(() {
                  _selected = _;
                });
              },
              currentIndex: _selected,
              items: [
                MyNavItem(iconData: Icons.login),
                MyNavItem(iconData: CupertinoIcons.phone, badgeCount: 2),
                MyNavItem(imageName: "logo"),
                MyNavItem(iconData: CupertinoIcons.chat_bubble, badgeCount: 1),
                MyNavItem(imageName: 'assets/icon/fav.png'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 23, sigmaY: 23),
        child: ColoredBox(
          color: Colors.white.withOpacity(.83),
          child: LayoutBuilder(builder: (_, constraints) {
            double lineSize = constraints.maxWidth / items.length;
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom + 10.h,
                top: 10.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map(
                      (e) {
                        int index = items.indexOf(e);
                        bool selected = currentIndex == index;

                        return SizedBox(
                          width: e.imageName == 'logo'
                              ? lineSize + 20
                              : lineSize - 5,
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPressed: selected
                                ? null
                                : () {
                                    onItemTap(index);
                                  },
                            child: e.imageName == 'logo'
                                ? Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SoundBar(),
                                        SizedBox(height: 4.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/logo.svg',
                                              height: 10.h,
                                            ),
                                            Transform.translate(
                                              offset: const Offset(0, .5),
                                              child: Text(
                                                "Line",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.lime,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : badges.Badge(
                                    showBadge: e.badgeCount > 0,
                                    badgeContent: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${e.badgeCount}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                    badgeStyle: badges.BadgeStyle(
                                      badgeColor: AppColors.red,
                                    ),
                                    child: e.imageName == null
                                        ? Icon(
                                            e.iconData!,
                                            color: selected
                                                ? AppColors.blue
                                                : Colors.grey,
                                            size: 30,
                                          )
                                        : Image.asset(
                                            e.imageName!,
                                            height: 30.w,
                                            width: 30.w,
                                            color: selected
                                                ? AppColors.blue
                                                : Colors.grey,
                                          ),
                                  ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  final List<MyNavItem> items;
  final int currentIndex;
  final void Function(int index) onItemTap;
}

class SoundBar extends StatefulWidget {
  const SoundBar({
    super.key,
  });

  @override
  State<SoundBar> createState() => _SoundBarState();
}

class _SoundBarState extends State<SoundBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int count = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

    _controller.addListener(() async {
      if (_controller.isCompleted) {
        if (count == 2) {
          await Future.delayed(const Duration(milliseconds: 300));
          count = 0;
        }
        _controller.reverse();
      }
      if (_controller.isDismissed) {
        count++;
        _controller.forward();
      }
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.w,
      width: 14.w,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.06),
        shape: BoxShape.circle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(flex: 2),
          _sound(2 + (2 * _animation.value)),
          const Spacer(),
          _sound(2 + (4 * _animation.value)),
          const Spacer(),
          _sound(2 + (2 * _animation.value)),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Container _sound(double h) {
    return Container(
      width: 2.w,
      height: h.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.lime,
      ),
    );
  }
}

class MyNavItem {
  String? imageName;
  IconData? iconData;
  int badgeCount;

  MyNavItem({
    this.imageName,
    this.iconData,
    this.badgeCount = 0,
  });
}
