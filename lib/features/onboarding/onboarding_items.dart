import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/resources/styles_manager.dart';

class OnBoardingItems extends StatelessWidget {
  const OnBoardingItems({
    super.key,
    required this.image,
    required this.mainText,
    required this.secText,
  });
  final String image;
  final String mainText;
  final String secText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, fit: .fill),
        SizedBox(height: 32.h),
        Text(
          mainText,
          textAlign: .center,
          style: getBoldStyle(color: ColorManager.black, fontSize: 24),
        ),
        SizedBox(height: 43.h),
        Text(secText, style: getRegularStyle(color: ColorManager.secTextColor)),
      ],
    );
  }
}
