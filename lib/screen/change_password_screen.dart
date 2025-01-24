import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_string.dart';

import '../blocs/change_password/change_password_bloc.dart';
import '../blocs/change_password/change_password_event.dart';
import '../blocs/change_password/change_password_state.dart';
import '../utils/app_common/app_common_appbar.dart';
import '../utils/app_common/app_font_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        bottomNavigationBar: BottomNavigation(currentIndex: 2),
        appBar: CommonAppBar(
          backgroundColor: AppColors.kWhite,
          title: AppString.changePassword,
          iconData: Icons.arrow_back,
        ),
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context);
            } else if (state is ChangePasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),

                        child: Center(
                          child: TextFormField(
                            style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                            controller: currentPassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                hintText: AppString.currentPassword,
                                hintStyle: AppFontStyles.headlineMedium(
                                fontSize: 16,
                                color: AppColors.kLightGrey,
                                fontWeight: FontWeight.w400
                            ),
                                prefixIcon: Icon(Icons.lock_open,  color: AppColors.kBlack,)
                            ),
                          ),
                        ),
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),

                        child: Center(
                          child: TextFormField(
                            style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                            controller: newPasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                hintText: AppString.newPassword,
                                hintStyle: AppFontStyles.headlineMedium(
                                    fontSize: 16,
                                    color: AppColors.kLightGrey,
                                    fontWeight: FontWeight.w400
                                ),
                                prefixIcon: Icon(Icons.lock_outline,  color: AppColors.kBlack,)
                            ),
                          ),
                        ),
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),

                        child: Center(
                          child: TextFormField(
                            style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                hintText: AppString.confirmPassword,
                                hintStyle: AppFontStyles.headlineMedium(
                                    fontSize: 16,
                                    color: AppColors.kLightGrey,
                                    fontWeight: FontWeight.w400
                                ),
                                prefixIcon: Icon(Icons.lock_outline,  color: AppColors.kBlack,)
                            ),
                          ),
                        ),
                      ),),
                  ),
                  SizedBox(height: 20,),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    builder: (context, state) {
                      if (state is ChangePasswordLoading) {
                        return const CircularProgressIndicator();
                      }else if(state is ChangePasswordSuccess){
                        setState(() {
                          currentPassword.clear();
                          newPasswordController.clear();
                          confirmPasswordController.clear();
                        });
                      }
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kRed,
                                AppColors.kRed1,
                              ], // Define your gradient colors
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Match button's border radius
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              final oldPassword = currentPassword.text.trim();
                              final newPassword = newPasswordController.text.trim();
                              final confirmPassword = confirmPasswordController.text.trim();
                              if (_formKey.currentState!.validate()) {
                                context.read<ChangePasswordBloc>().add(
                                  ChangePasswordSubmitted(
                                    oldPassword: oldPassword,
                                    newPassword: newPassword,
                                    confirmPassword: confirmPassword,
                                  ),
                                );

                              }
                              // Action for booking
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              // Set transparent as the background
                              shadowColor: Colors.transparent,
                              // Remove default button shadow
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Match border radius
                              ),
                            ),
                            child: Text(
                              AppString.submit.toUpperCase(),
                              style: AppFontStyles.headlineMedium(
                                color: AppColors.kWhite,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ])),
          ),
        ));
  }
}
