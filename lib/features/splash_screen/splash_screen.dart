import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/image_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      context.go("/botomnavigation/2");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.logo,
              width: SizeConstants.height(context) * .3,
              height: SizeConstants.height(context) * .3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            CustomText(
              data: 'Welcome to Masters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
