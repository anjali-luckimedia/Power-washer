import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'app_font_styles.dart';

class AppCommonBtn {
  static ElevatedButton kElevatedButton({
    required VoidCallback onPressed,
    required String BtnText,
    double fontSize = 20,
    Color color = AppColors.kBlack,
    Color? btnColor, // Made nullable to handle the default color within the function body
  }) {
    // Set a default value for btnColor if it's not provided
    btnColor ??= AppColors.kWhite.withOpacity(.5);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: btnColor),
        ),
      ),
      child: Text(
        BtnText,
        style: AppFontStyles.headlineMedium(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold),
      ),
    );
  }


  static Container kElevatedButtonForAdmin({
    required VoidCallback onPressed,
    required String BtnText,
    double fontSize = 20,
    double? width,
    BorderRadius? borderRadius,
    Color color = AppColors.kBlack,
    Color? btnColor, // Made nullable to handle the default color within the function body
    Color? borderColor, // Made nullable to handle the default color within the function body
  }) {
    // Set a default value for btnColor if it's not provided
    btnColor ??= AppColors.kWhite.withOpacity(.5);
    borderColor ??= AppColors.kDarkGrey;
    borderRadius ??= BorderRadius.circular(30);
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            //borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(
          BtnText,
          style: AppFontStyles.btnTextStyle(
            color: color,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
