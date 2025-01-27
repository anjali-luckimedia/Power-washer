import 'package:flutter/material.dart';
import 'package:power_washer/screen/auth_screen/login_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Images Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Column
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.splash3Image,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10,),
                    Image.asset(
                      AppImages.splash2Image,
                      //height: 530,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Right Column
              Expanded(
                flex: 1,
                child: Image.asset(
                  AppImages.splash4Image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          // Overlay Background
          Container(width:double.infinity,child: Image.asset(AppImages.bgImage,fit: BoxFit.cover,)),

          // Foreground Gradient and Text
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Stack(
                children: [
                  // Bottom Vector Image
                  Image.asset(
                    AppImages.splashVectorImage,
                    fit: BoxFit.cover,
                  ),
                  // Welcome Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 110),
                        Text(
                          AppString.welcome,
                          style: AppFontStyles.headlineMedium(
                              color: AppColors.kWhite,
                              fontSize: 30,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Text(
                          AppString.gotDirt,
                          style: AppFontStyles.headlineMedium(
                              color: AppColors.kWhite,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          AppString.findWashing,
                          style: AppFontStyles.headlineMedium(
                              color: AppColors.kWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(), // Replace with your login screen
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppColors.kYellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


