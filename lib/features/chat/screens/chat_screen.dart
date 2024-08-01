import 'dart:math';
import 'dart:ui';

import 'package:chatline_demo/common/data/data.dart';
import 'package:chatline_demo/common/models/person_model.dart';
import 'package:chatline_demo/common/style/app_colors.dart';
import 'package:chatline_demo/common/widget/gifts.dart';
import 'package:chatline_demo/features/chat/model/chat_model.dart';
import 'package:chatline_demo/features/profile/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:string_validator/string_validator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.person});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  final PersonModel person;
}

class _ChatScreenState extends State<ChatScreen> {
  bool isCallActive = false;
  bool isAddOpen = false;
  bool isMicOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 80,
                bottom: MediaQuery.paddingOf(context).bottom + 100,
                left: 20,
                right: 20,
              ),
              itemCount: Data().chats.length,
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                var c = Data().chats[index];
                if (c.content is ImageChatContent) {
                  var content = c.content as ImageChatContent;
                  return Align(
                    alignment:
                        c.isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: .8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.asset(content.image),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              c.time,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF7A7A7A),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  );
                }
                if (c.content is VideoChatContent) {
                  var content = c.content as VideoChatContent;
                  return Align(
                    alignment:
                        c.isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: .8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          LayoutBuilder(builder: (context, constraints) {
                            return SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.asset(
                                      content.image,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 4, sigmaY: 4),
                                        child: ClipPath(
                                          clipper: PlayButtonClipper(),
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 45.w,
                                            width: 45.w,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(.6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              c.time,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF7A7A7A),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  );
                }

                if (c.content is StickerChatContent) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (c.content as StickerChatContent).gift.widget((_) {}),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icon/tick.png',
                            width: 17,
                            height: 17,
                          ),
                          Text(
                            'You have received a rabbit',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          if (c.isSent)
                            Text(
                              c.status == 3 ? "visto " : 'sent ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontFamily: 'SF',
                              ),
                            ),
                          Text(
                            c.time,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF7A7A7A),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }

                if (c.content is AudioChatContent) {
                  c.content = c.content as AudioChatContent;
                  return Align(
                    alignment:
                        c.isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: c.isSent
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: c.isSent
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            CupertinoButton(
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.play_circle_outline_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            Image.asset(
                              'assets/icon/wave2.png',
                              height: 34.w,
                              width: 34.w,
                            ),
                            Image.asset(
                              'assets/icon/wave2.png',
                              height: 34.w,
                              width: 34.w,
                            ),
                            Image.asset(
                              'assets/icon/wave2.png',
                              height: 34.w,
                              width: 34.w,
                            ),
                            Image.asset(
                              'assets/icon/wave2.png',
                              height: 34.w,
                              width: 34.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              (c.content as AudioChatContent).duration,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (c.isSent)
                              Text(
                                c.status == 3 ? "visto " : 'sent ',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontFamily: 'SF',
                                ),
                              ),
                            Text(
                              c.time,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF7A7A7A),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }

                var content = c.content as TextChatContent;

                return Align(
                  alignment:
                      c.isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: .8,
                    child: Align(
                      alignment: c.isSent
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: c.isSent ? Colors.white : AppColors.chatBubble,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: c.isSent
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (isURL(content.message.trim())) {
                                  //
                                }
                              },
                              child: SelectableText(
                                content.message,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: isURL(content.message.trim())
                                      ? Colors.blue
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (c.isSent)
                                  Text(
                                    c.status == 3 ? "visto " : 'sent ',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontFamily: 'SF',
                                    ),
                                  ),
                                Text(
                                  c.time,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF7A7A7A),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildAppBar(),
          ),
          Positioned(
            // bottom: MediaQuery.paddingOf(context).bottom * 1.1 + 10,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom + 12.w,
                    top: 12.w,
                    left: 12.w,
                    right: 12.w,
                  ),
                  decoration: BoxDecoration(
                    // color: const Color(0xFFEFEFEF).withOpacity(.82),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEFEFEF).withOpacity(.82),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/icon/plus_circle.png',
                                  height: 40,
                                  width: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isAddOpen = true;
                                  });
                                },
                              ),
                              Expanded(
                                child: CupertinoTextField(
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  decoration: const BoxDecoration(),
                                  textInputAction: TextInputAction.send,
                                  placeholder: "Message",
                                ),
                              ),
                              CupertinoButton(
                                child: Image.asset(
                                  'assets/icon/star.png',
                                  height: 20.w,
                                  width: 20.w,
                                ),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    builder: (context) {
                                      return const _GiftPopUp();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icon/wave.png',
                            height: 28.w,
                            width: 28.w,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isMicOpen = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom:
                isMicOpen ? MediaQuery.paddingOf(context).bottom + 80.h : -100,
            left: 12.w,
            right: 12.w,
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceOut,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 6, right: 6, bottom: 6, left: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  const _ColoredMicrophone(),
                  SizedBox(width: 8.w),
                  Text(
                    '0:03',
                    style: TextStyle(
                      color: AppColors.active,
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Transform.rotate(
                      angle: pi * .25,
                      child: Image.asset(
                        'assets/icon/plus_circle.png',
                        color: Colors.blue,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isMicOpen = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            left: isAddOpen ? -4.w : -190.w,
            bottom: MediaQuery.paddingOf(context).bottom + 12.h,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: Transform.scale(
              scale: .8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Transform.rotate(
                        angle: pi * .25,
                        child: Image.asset(
                          'assets/icon/plus_circle.png',
                          color: Colors.blue,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isAddOpen = false;
                        });
                      },
                    ),
                    SizedBox(width: 32.w),
                    CupertinoButton(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(120),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Iconsax.video_square,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 32.w),
                    CupertinoButton(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(120),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        IconlyLight.image,
                        color: Colors.grey,
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

  Widget _buildAppBar() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(26.w)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 5.h,
            bottom: 12.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE4E4E4).withOpacity(.82),
            // borderRadius: BorderRadius.vertical(bottom: Radius.circular(26.w)),
          ),
          child: Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ProfileScreen(person: widget.person),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.person.image,
                        width: 40.w,
                        height: 40.w,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.person.name,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  height: 1,
                                  color: AppColors.black,
                                ),
                              ),
                              if (widget.person.isVerified)
                                Image.asset(
                                  'assets/icon/verified.png',
                                  width: 14.w,
                                  height: 14.w,
                                ),
                            ],
                          ),
                          if (widget.person.isActive)
                            Row(
                              children: [
                                const Text("En Linea"),
                                const SizedBox(width: 8),
                                Container(
                                  height: 9.w,
                                  width: 9.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.lime,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isCallActive = !isCallActive;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isCallActive
                        ? Colors.black
                        : const Color(0xFFE4E4E4).withOpacity(.0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "1:39",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              isCallActive ? Colors.white : Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      AnimatedRotation(
                        turns: isCallActive ? .7 : 1.05,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceOut,
                        child: Icon(
                          CupertinoIcons.phone_fill,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/menu.png',
                  height: 14.w,
                  width: 14.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColoredMicrophone extends StatefulWidget {
  const _ColoredMicrophone();

  @override
  State<_ColoredMicrophone> createState() => _ColoredMicrophoneState();
}

class _ColoredMicrophoneState extends State<_ColoredMicrophone>
    with SingleTickerProviderStateMixin {
  Color color = AppColors.active;

  late AnimationController _controller;
  late Animation<Color?> _animation;
  int count = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 400),
    );

    _animation = ColorTween(begin: AppColors.active, end: AppColors.blue)
        .animate(_controller);

    _controller.addListener(() async {
      color = _animation.value ?? color;

      if (_controller.isCompleted) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          _controller.reverse();
        }
      }
      if (_controller.isDismissed) {
        if (mounted) {
          _controller.forward();
        }
      }
      if (mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Iconsax.microphone_25,
      color: color,
    );
  }
}

class _GiftPopUp extends StatefulWidget {
  const _GiftPopUp();

  @override
  State<_GiftPopUp> createState() => _GiftPopUpState();
}

class _GiftPopUpState extends State<_GiftPopUp> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(50),
      ),
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            // height: 500,
            padding: EdgeInsets.only(
              top: 24.h,
              bottom: MediaQuery.paddingOf(context).bottom + 24.h,
              left: 24.w,
              right: 24.w,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFCECECE).withOpacity(.67),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            'assets/icon/star.png',
                            height: 15.w,
                            width: 15.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "most popular",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFF3C3C3C),
                            ),
                          ),
                          const Spacer(flex: 4),
                        ],
                      ),
                    ),
                    Coin1().widget((_) {
                      _giftConfirm();
                    }),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    const Spacer(),
                    Coin5().widget((_) {
                      _giftConfirm();
                    }),
                    const Spacer(flex: 2),
                    Coin30().widget((_) {
                      _giftConfirm();
                    }),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 48.h),
                Row(
                  children: [
                    Coin120().widget((_) {
                      _giftConfirm();
                    }),
                    SizedBox(width: 20.w),
                    Coin200().widget((_) {
                      _giftConfirm();
                    }),
                  ],
                ),
                SizedBox(height: 62.h),
                Coin1000().widget((_) {
                  _giftConfirm();
                }),
                SizedBox(height: 44.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/rabbit.svg',
                      height: 10.h,
                      colorFilter: const ColorFilter.srgbToLinearGamma(),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "If you want to send a monarch you need to be Duquesse category",
                      style: TextStyle(
                        fontSize: 8.sp,
                      ),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _giftConfirm() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return const _GiftConfirm();
      },
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }
}

class _GiftConfirm extends StatelessWidget {
  const _GiftConfirm();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(
            top: 32.h,
          ),
          width: 281.w,
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/svg/rabbit.svg',
                height: 22.h,
                width: 22.w,
              ),
              SizedBox(height: 18.h),
              Text(
                'are you sure to send?',
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Spacer(),
                  CupertinoButton(
                    child: Text(
                      "cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  CupertinoButton(
                    child: Text(
                      "yes",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double radius = size.width / 2;

    path.addOval(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius));

    final Path innerPath = Path();

    path.moveTo(16, 12);
    path.lineTo(size.width - 12, (size.height - 0) / 2);
    path.lineTo(16, size.height - 12);
    path.close();

    path.addPath(innerPath, Offset.zero);
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
