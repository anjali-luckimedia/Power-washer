import 'package:flutter/material.dart';
import 'package:power_washer/screen/splash_screen_2.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState

    navigateScreen();
    super.initState();
  }

  navigateScreen(){
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen2(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(width:double.infinity,child: Image.asset(AppImages.splashImage,fit: BoxFit.cover,)),
          Container(width:double.infinity,child: Image.asset(AppImages.bgImage,fit: BoxFit.cover,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.logoImage,scale: 6.0,),
              Image.asset(AppImages.gotDirtImage,scale: 6.0,),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(AppImages.locatorImage,scale: 6.0,),
                SizedBox(height: 8),
                Text(
                  'locator',
                  style: AppFontStyles.headlineMedium(
                    color: AppColors.kWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
