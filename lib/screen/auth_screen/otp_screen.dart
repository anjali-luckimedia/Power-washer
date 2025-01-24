import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:power_washer/blocs/resend_otp/resend_otp_bloc.dart';
import 'package:power_washer/blocs/resend_otp/resend_otp_state.dart';
import 'package:power_washer/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/resend_otp/resend_otp_event.dart';
import '../../blocs/verify_otp/verify_otp_event.dart';
import '../../blocs/verify_otp/verify_otp_state.dart';
import '../../utils/app_common/app_common_btn.dart';
import '../home_screen.dart';

class OtpScreen extends StatefulWidget {
  String? otp;
   OtpScreen({Key? key,this.otp,}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _pinController = TextEditingController();
  bool buttonEnable = false;
  bool isLoading = false;
  String? deviceToken;
  String? deviceType;
  String? userId ;
  late SharedPreferences preferences;
  PinTheme pinTheme = PinTheme(

    shape: PinCodeFieldShape.box,
    inactiveFillColor:  AppColors.kWhite,
    activeFillColor: AppColors.kWhite,
    selectedFillColor:AppColors.kWhite ,
    borderRadius: BorderRadius.circular(5),
    disabledColor: AppColors.kWhite,
    fieldHeight: 50,
    fieldWidth: 50,
    inactiveColor: AppColors.kWhite, // Change inactive to green
    activeColor: AppColors.kWhite, // Change active to green
    selectedColor: AppColors.kWhite, // Change selected to green
  );

  @override
  void initState() {
    print(widget.otp);
    initPreference();
    // TODO: implement initState
    super.initState();
  }
  void initPreference() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = preferences.getString(AppString.kPrefDeviceToken);
      deviceType = preferences.getString(AppString.kPrefDeviceType);
      userId = preferences.getString(AppString.kPrefUserIdKey);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:   (context) => VerifyOtpBloc(),
      child: Scaffold(
        body: BlocListener<VerifyOtpBloc,VerifyOtpState>(
          listener: (context, state) async {
          if (state is VerifyOtpLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is VerifyOtpSuccess) {


          }  else if (state is VerifyOtpFailure) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(width:double.infinity,child: Image.asset(AppImages.otpBgImage,fit: BoxFit.cover,)),
                Container(width:double.infinity,child: Image.asset(AppImages.otpOverlayImage,fit: BoxFit.cover,)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Center(child: Image.asset(AppImages.logoImage,scale: 6.0,)),

                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(AppString.otpVerification,style: AppFontStyles.dinTextStyle(color: AppColors.kWhite,fontSize: 30),)),
                    Divider(color: AppColors.kWhite,thickness: 2,endIndent: 130,indent: 130,),
                    Center(child: Text(AppString.otpSentEmail,style: AppFontStyles.headlineMedium(color: AppColors.kWhite,fontSize: 16,fontWeight: FontWeight.w400),)),
                    SizedBox(height: 5,),
                    Center(child: Text(AppString.yourEmail,style: AppFontStyles.headlineMedium(color: AppColors.kWhite,fontSize: 16,fontWeight: FontWeight.w400),)),
                    SizedBox(height: 25,),

                    Padding(
                      padding: const EdgeInsets.only(left: 55.0,right: 55),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        keyboardType: TextInputType.number,
                        controller: _pinController,
                        obscureText: true,
                        animationType: AnimationType.fade,
                        enableActiveFill: true,

                        textStyle: TextStyle(
                          color: AppColors.kBlack,
                          fontSize: 24, // Customize the font size and color
                        ),
                        blinkWhenObscuring: true,
                        blinkDuration: Duration(seconds: 3),
                        pinTheme: pinTheme,
                        onChanged: (value) {
                          print(value);
                        },
                        onCompleted: (value) {
                          // Change all fields to green when the code is complete
                          setState(() {
                            // Update the pinTheme to reflect the green border when completed
                            pinTheme = PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              inactiveFillColor:  AppColors.kWhite,
                              activeFillColor: AppColors.kWhite,
                              fieldHeight: 50,
                              selectedFillColor:AppColors.kWhite ,
                              disabledColor: AppColors.kWhite,
                              fieldWidth: 50,

                              inactiveColor: AppColors.kWhite, // Change inactive to green
                              activeColor: AppColors.kWhite, // Change active to green
                              selectedColor: AppColors.kWhite, // Change selected to green
                            );
                           // buttonEnable = true;
                          });
                        },
                      ),
                    ),
                    BlocConsumer<ResendOtpBloc, ResendOtpState>(
                      listener: (context, state) async {
                        if (state is ResendOtpSuccess) {
                          // Navigate based on role
                          // Show error message
                         // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0),));
                        } else if (state is ResendOtpFailure) {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ResendOtpLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color:  AppColors.kBlack,
                            ),
                          );
                        } else {
                          return RichText(
                            text: TextSpan(
                              //style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: AppString.resendMessage,
                                  style: AppFontStyles.headlineMedium(
                                      color: AppColors.kWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),),
                                TextSpan(text: AppString.resendAgain,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.read<ResendOtpBloc>().add(
                                        ResendOtpButtonPressed( ),
                                      );
                                    },

                                  style: AppFontStyles.headlineMedium(
                                      color: AppColors.kWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),),
                              ],
                            ),
                          );

                        }
                      },
                    ),

                    SizedBox(height: 25,),
                    BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                      listener: (context, state) async {
                        if (state is VerifyOtpSuccess) {
                          // Navigate based on role
                          // Show error message
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0),));
                        } else if (state is VerifyOtpFailure) {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is VerifyOtpLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color:  AppColors.kBlack,
                            ),
                          );
                        } else {
                          return  Center(
                            child: AppCommonBtn.kElevatedButton(onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                if(_pinController.text == widget.otp && _pinController.text.isNotEmpty && userId.toString() != ''){
                                  context.read<VerifyOtpBloc>().add(
                                    VerifyOtpButtonPressed(
                                      userId: userId.toString(), otp: _pinController.text, deviceToken: deviceToken.toString(), deviceType: deviceType.toString(),
                                    ),
                                  );
                                }
                                print('first');
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));
                                // Handle form submission if validation passes
                              }else{

                              }
                            }, btnColor: AppColors.kWhite,BtnText: AppString.verifyNow.toUpperCase(),),

                          );
                        }
                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
