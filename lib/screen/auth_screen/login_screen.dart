import 'package:flutter/material.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../../utils/app_common/app_common_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressSignUpController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  int isImageExpanded = 1;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Stack(
        children: [
          // Background Images
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.splash3Image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.4, // 50% of the screen height
                      ),
                      SizedBox(height: 10,),
                      Image.asset(
                        AppImages.loginImage,
                        //fit: BoxFit.cover,
                       // height: MediaQuery.of(context).size.height * 0.58,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 20,),
              Expanded(
                flex: 1,
                child: Image.asset(
                  AppImages.splash4Image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          Container(width:double.infinity,child: Image.asset(AppImages.overlayImage,fit: BoxFit.cover,)),
          // Foreground Gradient and Text

          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AppImages.logoImage,scale: 7.0,)),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isImageExpanded = 1;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/1.png',
                                  fit: BoxFit.contain,
                                  color: isImageExpanded == 1?AppColors.kRed:AppColors.kRed.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 85.0,top: 15),
                                child: GestureDetector( onTap: (){
                                  setState(() {
                                    isImageExpanded = 1;
                                  });
                                },child: Text(AppString.signIn,style: AppFontStyles.dinTextStyle(fontSize: 28),)),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isImageExpanded = 2;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/2.png',
                                  fit: BoxFit.contain,
                                  color: isImageExpanded == 2?AppColors.kRed:AppColors.kRed.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 85.0,top: 15),
                                child: GestureDetector( onTap: (){
                                  setState(() {
                                    isImageExpanded = 2;
                                  });
                                },child: Text(AppString.signUp,style: AppFontStyles.dinTextStyle(fontSize: 28),)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              
              
              
                  ///sign in
                  isImageExpanded == 1? Padding(
                    padding: const EdgeInsets.only(left: 5,right: 7.5),
                    child:Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: AppColors.kRed,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  child: CommonTextFormField(
                                    controller: emailAddressController,
                                    hintText: AppString.emailAddress,
                                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.kYellow),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  child: CommonTextFormField(
                                    controller: passwordController,
                                    hintText: AppString.password,
                                    prefixIcon: Icon(Icons.lock_outline, color: AppColors.kYellow),
                                    suffixIcon: Icon(Icons.visibility, color: AppColors.kYellow),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      AppString.forgotPassword,
                                      style: AppFontStyles.headlineMedium(
                                        fontSize: 18,
                                        color: AppColors.kWhite,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Center(
                                  child: Text(
                                    AppString.newMember,
                                    style: AppFontStyles.headlineMedium(
                                      fontSize: 18,
                                      color: AppColors.kWhite,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 35),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20, // Adjust the vertical position of the button
                          child: AppCommonBtn.kElevatedButton(
                            onPressed: () {
                              // Add your button logic here
                            },
                            btnColor: AppColors.kWhite,
                            BtnText: AppString.signIn.toUpperCase(),
                          ),
                        ),
                      ],
                    ),

                  ):Wrap(),
                 ///sign up
              
                  isImageExpanded == 2
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5, right: 7.5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.kRed,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      child: CommonTextFormField(
                                        controller: nameController,
                                        hintText: AppString.name,
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: AppColors.kYellow,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: CommonTextFormField(
                                        controller: emailAddressSignUpController,
                                        hintText: AppString.emailAddress,
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: AppColors.kYellow,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: CommonTextFormField(
                                        controller: passwordSignUpController,
                                        hintText: AppString.password,
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: AppColors.kYellow,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.visibility,
                                          color: AppColors.kYellow,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: CommonTextFormField(
                                        controller: phoneNumberController,
                                        hintText: AppString.phone,
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: AppColors.kYellow,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        AppString.forgotPassword,
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 18,
                                            color: AppColors.kWhite,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: Text(
                                      AppString.alreadyHave,
                                      style: AppFontStyles.headlineMedium(
                                          fontSize: 18,
                                          color: AppColors.kWhite,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(height: 35),
                                  Center(
                                    child: AppCommonBtn.kElevatedButton(onPressed: (){}, btnColor: AppColors.kWhite,BtnText: AppString.signUp.toUpperCase(),),
                                    // child: ElevatedButton(
                                    //   onPressed: () {},
                                    //   style: ElevatedButton.styleFrom(
                                    //     backgroundColor: Colors.white,
                                    //     //padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //   ),
                                    //   child: Text(
                                    //     AppString.signUp.toUpperCase(),
                                    //     style: AppFontStyles.headlineMedium(
                                    //         fontSize: 18,
                                    //         color: AppColors.kBlack,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Wrap()
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}