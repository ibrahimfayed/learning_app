import 'package:flutter/material.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/features/onboarding/onboarding_items.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        OnBoardingItems(
          image: ImageAssets.firstOnBoardingImg,
          mainText: 'Shape Your Future',
          secText:
              "Your personal guide to university success and self-development. Let's start the journey",
        ),
      ],
    );
  }
}
