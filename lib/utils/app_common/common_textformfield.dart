import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'app_font_styles.dart';

class CommonTextFormField extends StatefulWidget {
  int?focusBorder;
  int?maxLines;
  FocusNode ? focusNode;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color errorTextColor;
  final bool obscureText; // New parameter to obscure text for passwords
   bool? readOnly; // New parameter to obscure text for passwords
  bool ? borderColor;
   CommonTextFormField({Key? key,this.readOnly,this.borderColor,required this.errorTextColor,this.maxLines,this.focusBorder,this.focusNode, required this.controller, this.keyboardType, this.textInputAction, this.onTap, this.validator, this.onChanged, required this.hintText, this.suffixIcon, this.onFieldSubmitted, this.obscureText = false, this.prefixIcon}) : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textAlign: TextAlign.left,
      onTap: widget.onTap,
      cursorColor: AppColors.kBlack,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: widget.obscureText, // Use the obscureText property here
      readOnly: widget.readOnly??false,
      decoration: InputDecoration(
        errorStyle:AppFontStyles.headlineMedium(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: widget.errorTextColor!,
        ) ,
        isDense:true ,
        contentPadding:  EdgeInsets.symmetric(horizontal: 18,vertical:(widget.suffixIcon == null) ? 12 : 0 ),
        hintText: widget.hintText,
        hintStyle: AppFontStyles.headlineMedium(
          fontSize: 16,
          color: AppColors.kLightGrey,
            fontWeight: FontWeight.w400
        ),
        suffixIcon:widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints:BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
        filled: true,
        fillColor: AppColors.kWhite,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:widget.borderColor == true?AppColors.kLightGrey: AppColors.kWhite, width: 1),
            //borderSide: BorderSide.none
            ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.borderColor == true?AppColors.kLightGrey: AppColors.kWhite, width: 1),
           // borderSide: BorderSide.none
            ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.borderColor == true?AppColors.kLightGrey: AppColors.kWhite, width: 1),
          //borderSide: BorderSide.none
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.kYellow, width: 1),
        ),
      ),
      style: AppFontStyles.bodyLarge(
        fontWeight: FontWeight.w500,
        color: AppColors.kBlack,
      ),
    );
  }
}
