import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/resources/styles_manager.dart';
import 'package:learning_app/core/routes/routes.dart';
import 'package:learning_app/core/widgets/custom_elevated_button.dart';
import 'package:learning_app/features/onboarding/custom_indicator.dart';
import 'package:learning_app/features/onboarding/first_screen.dart';
import 'package:learning_app/features/onboarding/second_screen.dart';
import 'package:learning_app/features/onboarding/skip_button.dart';
import 'package:learning_app/features/onboarding/third_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: .end,
            children: [
              SkipButton(),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  controller: _controller,
                  children: [FirstScreen(), SecondScreen(), ThirdScreen()],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -50.h),
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          CustomIndicator(active: index == 0),
                          SizedBox(width: 5.w),
                          CustomIndicator(active: index == 1),
                          SizedBox(width: 5.w),
                          CustomIndicator(active: index == 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                innerPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                outerPadding: EdgeInsets.symmetric(horizontal: 100.w),
                label: getButtonLabel(),
                backgroundColor: ColorManager.gradiant2,
                textStyle: getSemiBoldStyle(color: ColorManager.white),
                onTap: ()async {
                  final prefs =await SharedPreferences.getInstance();
                  prefs.setBool('onboarding', true);
                  if (!mounted)return;
                  if (index == 2) 
                  {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(Routes.login);
                  } 
                  else {
                    
                    _controller.animateToPage(
                      index + 1,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.linear,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getButtonLabel() {
    if (index == 0) {
      return 'Get started';
    } else if (index == 1) {
      return 'Continue';
    }
    return 'Sign In';
  }
}
