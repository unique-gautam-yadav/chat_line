// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:chatline_demo/common/models/person_model.dart';
import 'package:chatline_demo/common/page_tran.dart';
import 'package:chatline_demo/common/style/app_colors.dart';
import 'package:chatline_demo/features/chat/screens/chat_screen.dart';
import 'package:chatline_demo/features/profile/data/data.dart';
import 'package:chatline_demo/features/profile/screens/call_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.person,
  });

  final PersonModel person;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileMediaModel selected = media.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Image.asset(
                  'assets/icon/link.png',
                  height: 20.w,
                  width: 20.w,
                )),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Image.asset(
                  'assets/icon/bookmark.png',
                  height: 20.w,
                  width: 20.w,
                )),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 92.w + 30.w,
                            width: 92.w,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    widget.person.image,
                                    height: 92.w,
                                    width: 92.w,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 4, sigmaY: 4),
                                      child: Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(.38),
                                        ),
                                        child: Image.asset(
                                          'assets/icon/yo.png',
                                          height: 24.w,
                                          width: 24.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  "Callers",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                const Text(
                                  "10K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.person.name),
                              if (widget.person.isVerified)
                                Image.asset(
                                  'assets/icon/verified.png',
                                  width: 18,
                                  height: 14,
                                ),
                              Image.asset(
                                'assets/icon/crown.png',
                                width: 18,
                                height: 16,
                              )
                            ],
                          ),
                          const Text(
                            """Colombia 🇨🇴 
        En linea los Viernes , Sabados , y 
        Domingos 😘
        Modelo 😉
        Conductora 👀🤖
        """,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox.square(
              dimension: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  Image.asset(selected.image),
                  if (selected.isVideo)
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: ClipPath(
                            clipper: PlayButtonClipper(),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              height: 45.w,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 90.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: media.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selected = media[index];
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        ColoredBox(
                          color: Colors.black,
                          child: Opacity(
                            opacity: selected == media[index] ? .7 : 1,
                            child: Image.asset(media[index].image),
                          ),
                        ),
                        if (media[index].isVideo)
                          const Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/gift/coin_200.png',
                    height: 52.w,
                    width: 52.w,
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.person.name),
                      const Row(
                        children: [
                          Text(
                            "voizme",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA3A2A2),
                            ),
                          ),
                          Text(
                            " level",
                            style: TextStyle(
                              color: Color(0xFFA3A2A2),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/svg/rabbit.svg',
                        width: 16.w,
                        height: 16.w,
                        color: const Color(0xFFA3A2A2),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        CupertinoIcons.chat_bubble,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                        context,
                        CenterRevealPageRoute(
                          page: CallScreen(person: widget.person),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        IconlyBold.call,
                        color: AppColors.green,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30 + MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}
