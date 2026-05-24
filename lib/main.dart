import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/core/routes/route_generator.dart';
import 'package:learning_app/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final onBoarding = prefs.getBool('onboarding') ?? false;

  runApp(
    LearningApp(
      // onBoarding: onBoarding
    ),
  );
}

class LearningApp extends StatelessWidget {
  const LearningApp({
    super.key,
    //required this.onBoarding
  });
  //final bool onBoarding;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}
