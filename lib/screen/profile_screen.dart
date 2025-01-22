import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/user_profile/user_profile_bloc.dart';
import 'package:power_washer/blocs/user_profile/user_profile_event.dart';
import 'package:power_washer/blocs/user_profile/user_profile_state.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_common_appbar.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBLoc>().add(LoadUserProfilePageData());

    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 3),
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,

        title: AppString.profile,
        iconData: Icons.arrow_back,
      ),
      body: BlocBuilder<UserProfileBLoc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator(color: AppColors.kBlack,));
          } else if (state is UserProfileLoaded) {
            final userData = state.userProfileModel;

            nameController.text = userData.data!.first.userDetails!.name.toString();
            emailController.text = userData.data!.first.userDetails!.email.toString();
            phoneController.text = userData.data!.first.userDetails!.phone.toString();

            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   /* SizedBox(height: 50,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.kBlack,
                            )),
                        SizedBox(width: 120,),
                        Center(
                            child: Text(AppString.profile.toUpperCase(),
                                style: AppFontStyles.headlineMedium(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: AppColors.kBlack,
                                ))),
                      ],
                    ),*/
                    Divider(color: AppColors.kLightGrey,thickness: 1,),
                    SizedBox(height: 20,),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          ),
                          padding: EdgeInsets.all(2), // Adding padding for the border effect
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                 AppColors.kWhite,
                                 AppColors.kWhite,
                
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                            ),
                            child: Image.asset(userData.data!.first.userDetails!.profileImage.toString()),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(2), // Adding padding for the border effect
                
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.kWhite,
                                      AppColors.kWhite,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppColors.kRed,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(userData.data!.first!.userDetails!.fullName.toString(),style: AppFontStyles.headlineMedium(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.kBlack,
                    )),
                    SizedBox(height: 40,),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
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
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                
                                      prefixIcon: Icon(Icons.account_circle_rounded,  color: AppColors.kYellow,)
                                  ),
                                ),
                              ),
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
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
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),
                              child: Center(
                                child: TextFormField(
                                  style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                                    border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email_outlined,  color: AppColors.kYellow,)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
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
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock_outline,  color: AppColors.kYellow,),
                                      suffixIcon: Icon(Icons.visibility,  color: AppColors.kYellow,)
                
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
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
                                  controller: phoneController,
                                 decoration: InputDecoration(
                                     contentPadding: EdgeInsets.symmetric(vertical: 12),
                                     border: InputBorder.none,
                                     prefixIcon: Icon(Icons.phone,  color: AppColors.kYellow,)
                
                                 ),
                                ),
                              ),),
                          ),
                        ),
                        SizedBox(height: 35),
                
                        // Apply Button
                        Center(
                          child:Container(
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
                                AppString.update.toUpperCase(),
                                style: AppFontStyles.headlineMedium(
                                  color: AppColors.kWhite,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                
                  ],
                ),
              ),
            );
          } else if (state is UserProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
