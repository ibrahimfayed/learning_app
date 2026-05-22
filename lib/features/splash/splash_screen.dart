import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 5), (){
  //     Navigator.of(context).pushReplacementNamed(Routes.login);
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.gradiant1,
              ColorManager.gradiant2,
              ColorManager.gradiant3,
            ],
          ),
        ),
        child: Center(child: Image.asset(ImageAssets.splashLogo)),
      ),
    );
  }
}
