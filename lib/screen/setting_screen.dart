import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../utils/app_common/Bottom_navigation.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      //    _modalBottomSheetMenu();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.kBlack,
                    )),
                SizedBox(width: 120,),
                Center(child: Text(AppString.settings.toUpperCase(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w800,fontSize: 18,color: AppColors.kBlack,))),

              ],
            ),
            Divider(color: AppColors.kLightGrey,thickness: 1,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: _buildCard(
                    image: selectedIndex == 1?AppImages.yellowNotification:AppImages.notification, label: 'NOTIFICATION',index: 1
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: _buildCard(
                    image:selectedIndex == 2?AppImages.yellowChangePassword:AppImages.changePassword, label: 'CHANGE PASSWORD',index: 2
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: _buildCard(
                    image: selectedIndex == 3?AppImages.yellowMyRequest:AppImages.myRequest, label: 'MY REQUEST',index: 3
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex = 4;
                    });
                  },
                  child: _buildCard(
                    image:selectedIndex == 4?AppImages.yellowLogout:AppImages.logout, label: 'LOGOUT',index: 4
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      selectedIndex = 5;
                    });
                  },
                  child: _buildCard(
                    image:selectedIndex == 5?AppImages.yellowDelete: AppImages.delete, label: 'DELETE ACCOUNT',index: 5

                  ),
                ),

              ],
            ),
          ],
        ),
      ),


    );
  }

  Widget _buildCard({
    required String image,
    required String label,
    required int index
  }) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(2), // Adding padding for the border effect
      child: Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              selectedIndex == index? AppColors.kRed:AppColors.kWhite,
              selectedIndex == index? AppColors.kRed1:AppColors.kWhite,

            ],
            // Define your gradient colors here
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(image,)),
            SizedBox(height: 10,),
            Center(
              child: Text(
                label,
                style: AppFontStyles.headlineMedium(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: selectedIndex == index? AppColors.kWhite:AppColors.kBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
