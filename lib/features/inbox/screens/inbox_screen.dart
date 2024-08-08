import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:chatline_demo/common/data/data.dart';
import 'package:chatline_demo/common/models/person_model.dart';
import 'package:chatline_demo/common/style/app_colors.dart';
import 'package:chatline_demo/features/chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: CupertinoButton(
          onPressed: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED).withOpacity(.89),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Image.asset(
                    'assets/icon/plus.png',
                    width: 32.w,
                    height: 32.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(height: 12.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 140.h),
                    Row(
                      children: [
                        Text(
                          "Chats",
                          style: TextStyle(
                            fontSize: 43.sp,
                            color: AppColors.blackGray,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/icon/status.png',
                            height: 32.w,
                            width: 32.w,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 28.h),
                      itemCount: Data.inboxPersons.length,
                      itemBuilder: (context, index) {
                        var model = Data.inboxPersons[index];

                        return ChatCard(model: model);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(26.w),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
              child: Container(
                padding: EdgeInsets.only(
                  left: 26.w,
                  bottom: 26.h,
                  top: MediaQuery.paddingOf(context).top + 10.w,
                  right: 20.w,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0).withOpacity(.82),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(26.w),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 26.w,
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.all(8.w),
                      child: Image.asset(
                        'assets/icon/search.png',
                        height: 25.w,
                        width: 25.w,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8.w),
                    CupertinoButton(
                      padding: EdgeInsets.all(8.w),
                      child: badges.Badge(
                        badgeContent: Container(
                          // height: 12.h,
                          // width: 12.h,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "1",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        child: Image.asset(
                          'assets/icon/bell.png',
                          height: 25.w,
                          width: 25.w,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.model,
  });

  final PersonModel model;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (_) => ChatScreen(person: model)));
      },
      child: Row(
        children: [
          badges.Badge(
            position: model.isRequest
                ? badges.BadgePosition.bottomEnd(
                    bottom: 0,
                  )
                : badges.BadgePosition.bottomEnd(
                    bottom: 5,
                    end: 1,
                  ),
            showBadge: model.isRequest || model.isActive,
            badgeContent: model.isRequest
                ? Padding(
                    padding: const EdgeInsets.all(1),
                    child: Icon(
                      CupertinoIcons.chat_bubble_fill,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  )
                : null,
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.green,
              badgeGradient: model.isRequest
                  ? const badges.BadgeGradient.linear(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                          Color(0xFF389F22),
                          Color(0xFF389F22),
                          Color(0xFF66F56D),
                          Color(0xFF66F56D),
                        ])
                  : null,
            ),
            child: Image.asset(
              model.image,
              width: 54.w,
              height: 54.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        height: 1,
                        color: AppColors.black,
                      ),
                    ),
                    if (model.isVerified)
                      Image.asset(
                        'assets/icon/verified.png',
                        width: 14.w,
                        height: 14.w,
                      ),
                    const Spacer(),
                    Text(
                      model.time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    if (model.isTyping)
                      Text(
                        "Escribiendo...",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.typingGreen,
                            height: 1),
                      )
                    else
                      Text(
                        model.latestMessage,
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1,
                          color: model.isSent
                              ? AppColors.textGrey
                              : AppColors.black,
                        ),
                      ),
                    const Spacer(),
                    if (model.isSent)
                      Text(
                        model.status,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: model.onHold
                              ? AppColors.textHold
                              : AppColors.typingGreen,
                        ),
                      )
                    else if (model.isRequest)
                      const SizedBox.shrink()
                    else
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${model.newCount}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.white,
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
