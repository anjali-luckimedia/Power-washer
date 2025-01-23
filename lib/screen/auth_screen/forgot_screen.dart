import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../../blocs/forgot_password/forgot_password_event.dart';
import '../../blocs/forgot_password/forgot_password_state.dart';
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
  bool isLoading = false;

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:   (context) => ForgotPasswordBloc(),
      child: Scaffold(
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) async {
            if (state is ForgotPasswordLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is ForgotPasswordSuccess) {


            }  else if (state is ForgotPasswordFailure) {
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
                      BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                        listener: (context, state) async {
                          if (state is ForgotPasswordSuccess) {
                            // Navigate based on role
                            // Show error message
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0),));
                          } else if (state is ForgotPasswordFailure) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ForgotPasswordLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color:  AppColors.kBlack,
                              ),
                            );
                          } else {
                            return Center(
                              child: AppCommonBtn.kElevatedButton(onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  context.read<ForgotPasswordBloc>().add(
                                    ForgotButtonPressed(
                                      email: emailAddressController.text,
                                    ),
                                  );
                                }
                              }, btnColor: AppColors.kWhite,BtnText: AppString.send.toUpperCase(),),

                            );
                          }
                        },
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

