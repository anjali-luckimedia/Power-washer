
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import 'app_font_styles.dart';

class CommonWidget{

  Widget commonNoData(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50,),
        SvgPicture.asset(AppImages.noDataImage),
        SizedBox(height: 20,),
        Text(AppString.noData,style: AppFontStyles.headlineMedium(fontWeight: FontWeight.bold,fontSize: 20),),
        SizedBox(height: 20,),
        Text(
          AppString.noData1,
          style: AppFontStyles.headlineMedium(
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.kRed,
                  AppColors.kRed1
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
              BorderRadius.circular(10.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0),
                ),
              ),
              child:Text(
                AppString.kContinue.toUpperCase(),
                style: AppFontStyles
                    .headlineMedium(
                  color: AppColors.kWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


}