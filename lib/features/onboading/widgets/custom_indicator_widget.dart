import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIndicatorWidget extends StatelessWidget {
  const CustomIndicatorWidget({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: _currentIndex == index ? 24.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                gradient: _currentIndex == index
                    ? LinearGradient(
                        colors: [
                          AppColors.white,
                          AppColors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: _currentIndex == index ? null : AppColors.disableColour,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ),
    );
  }
}
