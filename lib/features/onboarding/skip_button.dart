
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/resources/styles_manager.dart';
import 'package:learning_app/core/routes/routes.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushReplacementNamed(Routes.login);
      },
      child: Text(
        'Skip',
        style: getRegularStyle(
          color: ColorManager.black,
          fontSize: 16.sp,
        ),
        textAlign: .end,
      ),
    );
  }
}