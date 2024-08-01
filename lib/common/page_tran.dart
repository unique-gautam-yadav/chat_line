import 'package:flutter/material.dart';

class CenterRevealPageRoute extends PageRouteBuilder {
  final Widget page;
  final bool moveUpwards;

  CenterRevealPageRoute({required this.page, this.moveUpwards = true})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));

            return Stack(
              children: [
                Center(
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: animation.drive(tween).value,
                      heightFactor: animation.drive(tween).value,
                      child: child,
                    ),
                  ),
                ),
                Center(
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      // widthFactor: animation.drive(tween).value,
                      heightFactor: animation.drive(tween).value,
                      // animation.value + ((1 - animation.value) + .1),
                      child: child,
                      // child: Transform.translate(
                      //   offset: Offset(
                      //       0.0,
                      //       (moveUpwards ? -1 : 1) *
                      //           50.0 *
                      //           (1.0 - animation.value)),
                      //   child: child,
                      // ),
                    ),
                  ),
                ),
              ],
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}
