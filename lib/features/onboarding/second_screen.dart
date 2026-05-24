import 'package:flutter/material.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/features/onboarding/onboarding_items.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        OnBoardingItems(
          image: ImageAssets.secondOnBoardingImg,
          mainText: 'Develop real-world skills',
          secText:
              "Skills that take you further. Simple tips and tools to help you grow beyond your university lectures.",
        ),
      ],
    );
  }
}
