import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

abstract class Gift {
  Widget widget(Function(Gift gift) onGift);
}

class Coin1 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) =>
      _SmallestGift(onTap: () => onGift(Coin1()));
}

class Coin5 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) {
    return _MidGift(
      onTap: () {
        onGift(Coin5());
      },
      image: 'assets/gift/coin_5.png',
      price: '5',
    );
  }
}

class Coin30 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) {
    return _MidGift(
      onTap: () {
        onGift(Coin30());
      },
      image: 'assets/gift/coin_30.png',
      price: '30',
    );
  }
}

class Coin120 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) {
    return _LargeGift(
      onTap: () {
        onGift(Coin120());
      },
      image: 'assets/gift/coin_120.png',
      price: '120',
      name: 'Marquise',
    );
  }
}

class Coin200 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) {
    return _LargeGift(
      onTap: () {
        onGift(Coin200());
      },
      image: 'assets/gift/coin_200.png',
      price: '200',
      name: 'Duquezza',
    );
  }
}

class Coin1000 extends Gift {
  @override
  Widget widget(Function(Gift gift) onGift) {
    return _LargestGift(
      onTap: () {
        onGift(Coin1000());
      },
    );
  }
}

class _SmallestGift extends StatelessWidget {
  const _SmallestGift({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onTap();
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 45.w / 2),
            padding: EdgeInsets.only(
              top: 45.w / 2 + 4.h,
              bottom: 12.h,
              left: 32.w,
              right: 32.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE7E7E7),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              "1",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              height: 45.w,
              width: 45.w,
              'assets/gift/coin_1.png',
            ),
          ),
        ],
      ),
    );
  }
}

class _LargestGift extends StatelessWidget {
  const _LargestGift({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // _giftConfirm();
        onTap();
      },
      child: Column(
        children: [
          Image.asset(
            'assets/gift/coin_1000.png',
            height: 142.w,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF9F9F9),
                      Color(0xFFD8D8D8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFFCCFFD3)),
                ),
                child: Image.asset(
                  'assets/icon/crown.png',
                  color: Colors.black,
                  height: 16.w,
                  width: 16.w,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF9F9F9),
                      Color(0xFFD8D8D8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFFCCFFD3)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/rabbit.svg',
                      height: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    const Icon(Icons.close),
                    SizedBox(width: 8.w),
                    Image.asset(
                      'assets/icon/aston_martin.png',
                      height: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Monarch",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color(0xFF5B5B5B),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "1000",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF626262),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF626262),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MidGift extends StatelessWidget {
  const _MidGift({
    required this.image,
    required this.price,
    required this.onTap,
  });

  final String image;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          onTap();
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45.w / 3),
              padding: EdgeInsets.only(
                top: 12.h,
                bottom: 12.h,
                left: 20.w,
                right: 20.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  SizedBox(width: 45.w),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                image,
                height: 45.w,
                width: 45.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LargeGift extends StatelessWidget {
  const _LargeGift({
    required this.image,
    required this.price,
    required this.name,
    required this.onTap,
  });

  final String image;
  final String price;
  final String name;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: (MediaQuery.sizeOf(context).width / 2) - 68 / 2,
        maxWidth: (MediaQuery.sizeOf(context).width / 2) - 68 / 2,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // _giftConfirm();
          onTap();
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 95.w / 2 + 10.h),
              padding: EdgeInsets.only(
                top: 4.h,
                bottom: 4.h,
                left: 8.w,
                right: 20.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon/crown.png',
                    height: 16.w,
                    width: 16.w,
                  ),
                  SizedBox(width: 75.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25.w,
              ),
              child: Image.asset(
                image,
                width: 75.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
