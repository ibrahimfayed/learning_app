import 'package:flutter/material.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/features/onboarding/onboarding_items.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        OnBoardingItems(
          image: ImageAssets.thirdOnBoardingImg,
          mainText: 'Explore student activities and campus opportunities',
          secText:
              "Don’t just study, live the experience. Join student clubs, find campus events, and make the most of your university life.",
        ),
      ],
    );
  }
}