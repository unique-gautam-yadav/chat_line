import 'dart:math';
import 'dart:ui';

import 'package:chatline_demo/common/models/person_model.dart';
import 'package:chatline_demo/common/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key, required this.person});

  final PersonModel person;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _micOff = false;
  bool _speakerOn = false;
  bool _videoOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 24,
                sigmaY: 24,
              ),
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset(
                  widget.person.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(.6),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.paddingOf(context).top,
            bottom: MediaQuery.paddingOf(context).bottom,
            left: MediaQuery.paddingOf(context).left,
            right: MediaQuery.paddingOf(context).right,
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  widget.person.image,
                  width: 100.w,
                  height: 100.w,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.person.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                      ),
                    ),
                    if (widget.person.isVerified)
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Image.asset(
                          'assets/icon/verified.png',
                          width: 18,
                          height: 14,
                        ),
                      ),
                    SizedBox(width: 10.w),
                    Image.asset(
                      'assets/icon/crown.png',
                      width: 18,
                      height: 16,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.call_outgoing5,
                      color: AppColors.green,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Llamando...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionButton(
                      onTap: () {
                        setState(() {
                          _micOff = !_micOff;
                        });
                      },
                      icon: Icons.mic_off,
                      selected: _micOff,
                      color: AppColors.blue,
                    ),
                    _actionButton(
                      onTap: () {
                        setState(() {
                          _speakerOn = !_speakerOn;
                        });
                      },
                      image: 'assets/icon/sound.png',
                      selected: _speakerOn,
                      color: AppColors.green,
                    ),
                    _actionButton(
                      onTap: () {
                        setState(() {
                          _videoOn = !_videoOn;
                        });
                      },
                      selected: _videoOn,
                      icon: Iconsax.video_slash,
                      color: AppColors.white,
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/video.png',
                        width: 32.w,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        """Remember that the camera
 is activated after one minute 
of iteration""",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.rotate(
                            angle: 2.35,
                            child: Icon(
                              IconlyBold.call,
                              color: Colors.white,
                              size: 35.w,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required VoidCallback onTap,
    required bool selected,
    required Color color,
    IconData? icon,
    String? image,
  }) {
    return CupertinoButton(
      onPressed: () {
        onTap();
      },
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: selected ? color : const Color(0xFFE1E1E1),
          shape: BoxShape.circle,
        ),
        child: image != null
            ? Image.asset(
                image,
                width: 32.w,
                height: 32.w,
              )
            : Icon(
                icon,
                color: Colors.black,
                size: 32.w,
              ),
      ),
    );
  }
}
