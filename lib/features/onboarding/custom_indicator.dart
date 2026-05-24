import 'package:flutter/material.dart';
import 'package:learning_app/core/resources/color_manager.dart';

class CustomIndicator extends StatelessWidget {
  final bool active;

  CustomIndicator({required this.active});

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? ColorManager.gradiant2: ColorManager.primary
      ),
       width: active ? 30 : 10, 
       height: 10,
        );
  }
}