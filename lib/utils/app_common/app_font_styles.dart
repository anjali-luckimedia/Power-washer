import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_washer/utils/app_colors.dart';


class AppFontStyles {
  static const String dinCondensed = 'DINCondensed';
  static TextStyle titleLarge({Color color = AppColors.kBlack,double fontSize = 32,}) {
    return  GoogleFonts.nunito(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
    );
  }
  // static TextStyle titleMedium({Color color = AppColors.kBlack,double fontSize = 30}) {
  //   return  TextStyle(
  //       fontFamily: baloo2,
  //       color: color,
  //       fontWeight: FontWeight.w600,
  //       fontSize: fontSize,
  //       height:1
  //   );
  // }
  // static TextStyle titleSmall({Color color = AppColors.kWhite}) {
  //   return  TextStyle(
  //       fontFamily: baloo2,
  //       color: color,
  //       fontWeight: FontWeight.w600,
  //       fontSize: 25,
  //       height: 1.2
  //   );
  // }
  static TextStyle dinTextStyle({Color color = AppColors.kWhite ,double fontSize = 18,FontWeight fontWeight = FontWeight.bold  }) {
    return  TextStyle(
      fontFamily: dinCondensed,
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }
  static TextStyle headlineLarge({Color color = AppColors.kWhite}) {
    return GoogleFonts.inter(
      color: color,
        fontWeight: FontWeight.w700,
        fontSize: 25,
    );
  }
  static TextStyle headlineMedium({Color color = AppColors.kWhite ,double fontSize = 18,FontWeight fontWeight = FontWeight.w400  }) {
    return GoogleFonts.nunito(
        color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
        height: 1.2
    );
  }
  static TextStyle headlineSmall({double fontSize = 22,Color color = AppColors.kWhite,FontWeight fontWeight = FontWeight.w600  }) {
    return GoogleFonts.inter(
        color:color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: 1
    );
  }

  static TextStyle bodyLarge({FontWeight fontWeight = FontWeight.w600 ,Color color= AppColors.kBlack}) {
    return  GoogleFonts.inter(
        color: color,
        fontWeight: fontWeight,
        fontSize: 16,
      height: 1.1
    );
  }
  static TextStyle bodyMedium({FontWeight fontWeight = FontWeight.w600,Color color= AppColors.kBlack}
  ) {
    return  GoogleFonts.inter(
        color: color,
        fontWeight: fontWeight,
        fontSize: 14,
        height: 1.2
    );
  }
  static TextStyle bodySmall({ FontWeight fontWeight = FontWeight.w600,Color color= AppColors.kBlack}) {
    return GoogleFonts.inter(
      color: color,
      fontWeight: fontWeight,
      fontSize: 12,
    );
  }

  static TextStyle smallText({ FontWeight fontWeight = FontWeight.w500,Color color= AppColors.kDarkGrey}) {
    return GoogleFonts.inter(
      color: color,
      fontWeight: fontWeight,
      fontSize: 9,
    );
  }

  static TextStyle btnTextStyle({double fontSize = 20, Color color= AppColors.kWhite,}) {
    return GoogleFonts.inter(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
    );
  }

}
