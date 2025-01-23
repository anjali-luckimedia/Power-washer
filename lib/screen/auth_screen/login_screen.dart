import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/sign_up/sign_up_bloc.dart';
import 'package:power_washer/screen/auth_screen/forgot_screen.dart';
import 'package:power_washer/screen/auth_screen/otp_screen.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../../blocs/sign_up/sign_up_event.dart';
import '../../blocs/sign_up/sign_up_state.dart';
import '../../utils/app_common/app_common_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool passwordVisibility = false;
  bool isLoading = false;
  String _deviceToken = '';
  String _deviceType = '';
  late SharedPreferences preferences;

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }


  @override
  void initState() {
    super.initState();
    initPreference();
    _getToken();
    getDeviceType();
  }

  void initPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  // _getToken() {
  //   FirebaseMessaging.instance.getToken().then((token) {
  //     if (token != null) {
  //       setState(() {
  //         _deviceToken = token;
  //         print('--------- $_deviceToken');
  //       });
  //     } else {
  //       print('Token is null');
  //     }
  //   });
  // }
/*_getToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      setState(() {
        _deviceToken = token ?? '';
        print('Device Token: $_deviceToken');
      });
    } catch (e) {
      print('Error fetching token: $e');
    }
  }*/


  _getToken() async {
    try {
      if (_deviceType == 'Ios') {
        // Fetch token from getAPNSToken for iOS
        String? token = await FirebaseMessaging.instance.getAPNSToken();
        if (token != null) {
          setState(() {
            _deviceToken = token;
            print('APNs Token: $_deviceToken');
          });
        } else {
          print('APNs Token is null');
        }
      } else {
        // Fetch token using Firebase for Android
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          setState(() {
            _deviceToken = token;
            print('Firebase Token: $_deviceToken');
          });
        } else {
          print('Firebase Token is null');
        }
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }


  getDeviceType() {
    if (Platform.isIOS || Platform.isMacOS) {
      setState(() {
        _deviceType = 'Ios';
        print(_deviceType);
      });
    } else if (Platform.isAndroid) {
      setState(() {
        _deviceType = 'Android';
        print(_deviceType);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: false,
      child: BlocProvider(

        create: (context) => SignUpBloc(),
        child: Scaffold(
          backgroundColor: AppColors.kBlack,
          body: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) async {
              if (state is SignUpLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is SignUpSuccess) {
                final otp = preferences.getString(AppString.kPrefOtpKey);
                final userId = preferences.getString(AppString.kPrefUserIdKey);

                // Navigate to HomeScreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  OtpScreen(otp: otp.toString(),userId: userId.toString(),)));
                // Navigator.pushReplacementNamed(context, '/homeScreen');


              }  else if (state is SignUpFailure) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: Stack(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(child: Image.asset(AppImages.logoImage,scale: 7.0,)),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0,right: 7),
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
                                        padding: const EdgeInsets.only(right: 90.0,top: 20),
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
                                        padding: const EdgeInsets.only(left: 90.0,top: 20),
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
                          isImageExpanded == 1?Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  height: 300,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    color: AppColors.kRed,
                                    margin: EdgeInsets.only(top: 0,bottom: 16,left: 6.5,right: 7.5
                                    ),
                                    //padding: const EdgeInsets.only(left: 5,right: 7.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            width: double.infinity,
                                            child: CommonTextFormField(
            
                                              errorTextColor: AppColors.kBlack,
                                              controller: emailAddressController,
                                              hintText: AppString.emailAddress,
                                              prefixIcon: Icon(Icons.email_outlined, color: AppColors.kYellow),
                                              validator: (value) => _validateField(value, "Email address"),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: double.infinity,
                                            child: CommonTextFormField(
            
                                              errorTextColor: AppColors.kBlack,
                                              controller: passwordController,
                                              hintText: AppString.password,
                                              prefixIcon: Icon(Icons.lock_outline, color: AppColors.kYellow),
                                              suffixIcon: Icon(Icons.visibility, color: AppColors.kYellow),
                                              validator: (value) => _validateField(value, "Password"),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Spacer(),

                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen(),));
                                                },
                                                child: Text(
                                                  AppString.forgotPassword,
                                                  style: AppFontStyles.headlineMedium(
                                                    fontSize: 18,
                                                    color: AppColors.kWhite,
                                                    fontWeight: FontWeight.w400,
                                                  ),
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
                                ),
                              ),
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) async {
                                  if (state is LoginSuccess) {
                                    // Navigate based on role
                                    // Show error message
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0),));
                                  } else if (state is LoginFailure) {
                                    // Show error message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.error)),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color:  AppColors.kBlack,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 150,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                        color: Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(1),
                                        child: AppCommonBtn.kElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              context.read<LoginBloc>().add(
                                                LoginButtonPressed(
                                                            email: emailAddressController.text,
                                                            password: passwordController.text,
                                                            deviceToken: _deviceToken,
                                                            deviceType: _deviceType,
                                                          ),
                                                        );
                                            }
                                            // if (_formKey.currentState!.validate()) {
                                            // print('first');
                                            // Handle form submission if validation passes
                                            //   }
                                            // Add your button logic here
                                          },
                                          btnColor: AppColors.kWhite,
                                          BtnText: AppString.signIn.toUpperCase(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 45,
                              ),

                            ],
                          ):Wrap(),
            
                         ///sign up
                          isImageExpanded == 2? Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  height: 435,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    color: AppColors.kRed,
                                    margin: EdgeInsets.only(top: 0,bottom: 16,left: 6.5,right: 7.5,),
                                    //padding: const EdgeInsets.only(left: 5,right: 7.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                              width: double.infinity,
                                              child: CommonTextFormField(
            
                                                errorTextColor: AppColors.kBlack,
                                                controller: nameController,
                                                hintText: AppString.name,
                                                prefixIcon: Icon(
                                                  Icons.account_circle,
                                                  color: AppColors.kYellow,
                                                ),
                                                validator: (value) => _validateField(value, "Name"),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: double.infinity,
                                              child: CommonTextFormField(
            
                                                errorTextColor: AppColors.kBlack,
                                                controller: emailAddressSignUpController,
                                                hintText: AppString.emailAddress,
                                                prefixIcon: Icon(
                                                  Icons.email_outlined,
                                                  color: AppColors.kYellow,
                                                ),
                                                validator: (value) => _validateField(value, "Email address"),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: double.infinity,
                                              child: CommonTextFormField(
                                                maxLines: 1,
                                                errorTextColor: AppColors.kBlack,
                                                controller: passwordSignUpController,
                                                hintText: AppString.password,
                                                obscureText: passwordVisibility,
                                                prefixIcon: Icon(
                                                  Icons.lock_outline,
                                                  color: AppColors.kYellow,
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    // Based on passwordVisible state choose the icon
                                                    passwordVisibility
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: AppColors.kYellow,
                                                  ),
                                                  onPressed: () {
                                                    // Update the state i.e. toogle the state of passwordVisible variable
                                                    setState(() {
                                                      passwordVisibility = !passwordVisibility;
                                                    });
                                                  },
                                                ),
            
                                                validator: (value) => _validateField(value, "Password"),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: double.infinity,
                                              child: CommonTextFormField(
                                                maxLines: 1,
                                                maxLength: 10,
                                                keyboardType: TextInputType.phone,
                                                errorTextColor: AppColors.kBlack,
                                                controller: phoneNumberController,
                                                hintText: AppString.phone,
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: AppColors.kYellow,
                                                ),
                                                validator: (value) => _validateField(value, "Phone Number"),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen(),));
                                                },
                                                child: Text(
                                                  AppString.forgotPassword,
                                                  style: AppFontStyles.headlineMedium(
                                                      fontSize: 18,
                                                      color: AppColors.kWhite,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
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
                                          const SizedBox(height: 25),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              BlocConsumer<SignUpBloc, SignUpState>(
                                listener: (context, state) async {
                                  if (state is SignUpSuccess) {
                                    // Navigate based on role
                                    final otp = preferences.getString(AppString.kPrefOtpKey);
                                    final userId = preferences.getString(AppString.kPrefUserIdKey);

                                      // Navigate to HomeScreen
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  OtpScreen(otp: otp.toString(),userId: userId.toString(),)));
                                      // Navigator.pushReplacementNamed(context, '/homeScreen');

                                  } else if (state is SignUpFailure) {
                                    // Show error message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.error)),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SignUpLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.kBlack,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 150,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(),
                                        color: Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 1,left: 1,bottom: 5,top: 1),
                                        child: AppCommonBtn.kElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              context.read<SignUpBloc>().add(
                                                SignUpButtonPressed(
                                                  name:nameController.text,
                                                  email: emailAddressSignUpController.text,
                                                  password: passwordSignUpController.text,
                                                  phone: phoneNumberController.text,
                                                  deviceToken: _deviceToken,
                                                  //deviceToken: 'asfjkhwskcfslkdncjkl',
                                                  deviceType: _deviceType,
                                                ),
                                              );
                                            }
                                            // Add your button logic here
                                          },
                                          btnColor: AppColors.kWhite,
                                          BtnText: AppString.signUp.toUpperCase(),
                                        ),
                                      ),
                                    );
                                  }
                                },

                              )
                            ],
                          )  : Wrap()
            
                        ],
                      ),
                    ),
                  ),
                ),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
