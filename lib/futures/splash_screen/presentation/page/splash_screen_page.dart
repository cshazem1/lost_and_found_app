import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/core/utils/constants/context_extension.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../generated/assets.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        _scale = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      context.navigator.pushReplacementNamed(AppRoutes.homeStore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePath =
        context.theme.brightness == Brightness.dark
            ? Assets.imagesSplashDark
            : Assets.imagesSplashLight;

    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: _scale),
          duration: const Duration(seconds: 4),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
