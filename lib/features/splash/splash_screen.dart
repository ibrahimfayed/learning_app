import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/core/resources/assets_manager.dart';
import 'package:learning_app/core/resources/color_manager.dart';
import 'package:learning_app/core/resources/styles_manager.dart';
import 'package:learning_app/core/routes/routes.dart';
import 'package:learning_app/core/widgets/custom_elevated_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _phase1Controller;
  Animation<Offset>? _logoSlide;
  Animation<Offset>? _textSlide;
  Animation<double>? _textFade;

  AnimationController? _phase2Controller;
  Animation<Offset>? _logoMove;
  Animation<double>? _logoScale;
  Animation<double>? _oldTextFadeOut;
  Animation<double>? _newContentFadeIn;
  Animation<double>? _semicircleFadeIn;
  Animation<Offset>? _semicircleSlideIn;

  @override
  void initState() {
    super.initState();
    _setupPhase1();
  }

  void _setupPhase1() {
    final c1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final logoSlide = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(3.0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(3.0, 0),
          end: const Offset(-0.5, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 60,
      ),
    ]).animate(c1);

    final textSlide =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: c1,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    final textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: c1,
        curve: const Interval(0.4, 0.85, curve: Curves.easeIn),
      ),
    );

    _phase1Controller = c1;
    _logoSlide = logoSlide;
    _textSlide = textSlide;
    _textFade = textFade;

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      c1.forward().then((_) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) _setupAndStartPhase2();
        });
      });
    });
  }

  void _setupAndStartPhase2() {
    final c2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    final logoMove = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: const Offset(0, -0.7),
    ).animate(CurvedAnimation(parent: c2, curve: Curves.easeInOut));

    final logoScale = Tween<double>(
      begin: 1.0,
      end: 1.6,
    ).animate(CurvedAnimation(parent: c2, curve: Curves.easeInOut));

    final oldTextFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: c2,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    final newContentFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: c2,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    final semicircleFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: c2,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    final semicircleSlideIn =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: c2,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );
    setState(() {
      _phase2Controller = c2;
      _logoMove = logoMove;
      _logoScale = logoScale;
      _oldTextFadeOut = oldTextFadeOut;
      _newContentFadeIn = newContentFadeIn;
      _semicircleFadeIn = semicircleFadeIn;
      _semicircleSlideIn = semicircleSlideIn;
    });

    c2.forward();
  }

  @override
  void dispose() {
    _phase1Controller?.dispose();
    _phase2Controller?.dispose();
    super.dispose();
  }

  bool get _phase2Started => _phase2Controller != null;

  @override
  Widget build(BuildContext context) {
    if (_logoSlide == null || _textSlide == null || _textFade == null) {
      return const Scaffold(body: SizedBox());
    }

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
        child: Stack(
          children: [
            if (_phase2Started)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _semicircleFadeIn!,
                  child: SlideTransition(
                    position: _semicircleSlideIn!,
                    child: Image.asset(
                      ImageAssets.semiCircle,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildLogo(),

                  if (!_phase2Started)
                    _buildOldText()
                  else
                    FadeTransition(
                      opacity: _oldTextFadeOut!,
                      child: _buildOldText(),
                    ),

                  if (_phase2Started)
                    FadeTransition(
                      opacity: _newContentFadeIn!,
                      child: _buildNewContent(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    Widget logo = Image.asset(
      ImageAssets.splashLogo,
      width: 81.w,
      height: 81.h,
      fit: BoxFit.scaleDown,
    );

    if (_phase2Started) {
      return SlideTransition(
        position: _logoMove!,
        child: ScaleTransition(scale: _logoScale!, child: logo),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SlideTransition(
          position: _logoSlide!,
          child: Transform.translate(offset: Offset(32.w, 0), child: logo),
        ),
        FadeTransition(
          opacity: _textFade!,
          child: SlideTransition(
            position: _textSlide!,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EDUON',
                  style: getMediumStyle(
                    fontSize: 50.sp,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  'Turn Learning On',
                  style: getLightStyle(
                    fontSize: 15.sp,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOldText() {
    return const SizedBox();
  }

  Widget _buildNewContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 120.h),
        Text(
          'All you need in one place',
          style: getLightStyle(fontSize: 15.sp, color: ColorManager.white),
        ),
        SizedBox(height: 30.h),
        CustomElevatedButton(
          innerPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          outerPadding: EdgeInsets.symmetric(horizontal: 100.w),
          //innerPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
          label: 'GET STARTED',
          onTap: () {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          },
          backgroundColor: ColorManager.white,
          textStyle: getMediumStyle(
            fontSize: 19.sp,
            color: ColorManager.gradiant1,
          ),
        ),
      ],
    );
  }
}
