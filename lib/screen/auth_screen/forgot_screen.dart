import 'package:flutter/material.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../../utils/app_common/app_common_btn.dart';
import '../../utils/app_common/common_textformfield.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController emailAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(width:double.infinity,child: Image.asset(AppImages.forgotBgImage,fit: BoxFit.cover,)),
            Container(width:double.infinity,child: Image.asset(AppImages.otpOverlayImage,fit: BoxFit.cover,)),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25,),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back,color: AppColors.kWhite,))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(alignment:Alignment.centerLeft,child: Text(AppString.forgotYourPassword,style: AppFontStyles.dinTextStyle(fontSize: 30),)),
                  Text(
                    AppString.forgotYourPasswordDetails,
                    style: AppFontStyles.headlineMedium(
                        color: AppColors.kWhite,
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    child: CommonTextFormField(
                      controller: emailAddressController,
                      errorTextColor: AppColors.kWhite,
                      hintText: '',
                      validator: (value) => _validateField(value, "Email address"),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: AppCommonBtn.kElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        print('first');

                        // Handle form submission if validation passes
                      }
                    }, btnColor: AppColors.kWhite,BtnText: AppString.send.toUpperCase(),),

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

