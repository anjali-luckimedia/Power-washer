import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/screen/auth_screen/login_screen.dart';
import 'package:power_washer/screen/change_password_screen.dart';
import 'package:power_washer/screen/my_request_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/delete_account/delete_account_bloc.dart';
import '../blocs/delete_account/delete_account_event.dart';
import '../blocs/delete_account/delete_account_state.dart';
import '../blocs/logout/logout_bloc.dart';
import '../blocs/logout/logout_event.dart';
import '../blocs/logout/logout_state.dart';
import '../utils/app_common/Bottom_navigation.dart';
import '../utils/app_common/app_common_appbar.dart';
import 'notification_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  int selectedIndex = 0;
  bool isLoggingOut = false;
  String? deviceToken;
  late SharedPreferences preferences;


  @override
  void initState() {
    initPreference();
    // TODO: implement initState
    super.initState();
  }
  void initPreference() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      deviceToken = preferences.getString(AppString.kPrefDeviceToken);
    });
    print(deviceToken);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,
        title: AppString.settings,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
          /*  SizedBox(height: 50,),
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
            ),*/
            Divider(color: AppColors.kLightGrey,thickness: 1,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()))
                          .whenComplete(() => selectedIndex = 0);
                    },
                    child: _buildCard(
                      image: selectedIndex == 1 ? AppImages.yellowNotification : AppImages.notification,
                      label: 'NOTIFICATION',
                      index: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between cards
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()))
                          .whenComplete(() => selectedIndex = 0);
                    },
                    child: _buildCard(
                      image: selectedIndex == 2 ? AppImages.yellowChangePassword : AppImages.changePassword,
                      label: 'CHANGE PASSWORD',
                      index: 2,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap:(){
                      setState(() {
                        selectedIndex = 3;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyRequestScreen(),));
                  
                    },
                    child: _buildCard(
                      image: selectedIndex == 3?AppImages.yellowMyRequest:AppImages.myRequest, label: 'MY REQUEST',index: 3
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between cards

                Flexible(
                  child: GestureDetector(
                    onTap:(){
                      setState(() {
                        selectedIndex = 4;
                      });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocListener<LogoutBloc, LogoutState>(
                            listener: (context, state) {
                              if (state is LogoutLoading) {
                                // Set the flag to true to show CircularProgressIndicator
                                setState(() {
                                  isLoggingOut = true;
                                });
                              } else if (state is LogoutSuccess) {
                                // Reset the flag and navigate to login page
                                setState(() {
                                  isLoggingOut = false;
                                });
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } else if (state is LogoutFailure) {
                                // Reset the flag and show an error message
                                setState(() {
                                  isLoggingOut = false;
                                });
                                Navigator.of(context)
                                    .pop(); // Close the current dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.error),
                                  ),
                                );
                              }
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  //backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      vertical: 24.0, horizontal: 15),
                                  titlePadding: const EdgeInsets.only(
                                      top: 25, left: 15, bottom: 12),
                                  title: Text("LOGOUT",
                                      style: AppFontStyles.headlineMedium(
                                        fontSize: 22,
                                        color:  AppColors.kBlack,
                                        fontWeight: FontWeight.bold
                                      )),
                                  content: isLoggingOut
                                      ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.kBlack,
                                      ))
                                      : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: SizedBox(
                                          width: 250,
                                          child: Text(
                                              "Do you want to logout?",
                                              style: AppFontStyles.headlineMedium(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color:  AppColors.kBlack,
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Divider(
                                          color:  AppColors.kLightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  contentPadding:
                                  const EdgeInsets.only(top: 8),
                                  buttonPadding: EdgeInsets.zero,
                                  actionsPadding:
                                  const EdgeInsets.only(bottom: 10),
                                  actions: isLoggingOut
                                      ? []
                                      : <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        context.read<LogoutBloc>().add(
                                          LogoutButtonPressed(
                                            deviceToken:deviceToken.toString(),
                                          ),
                                        );
                                      },
                                      child: Text("YES",
                                          style: AppFontStyles.headlineMedium(
                                            fontSize: 14,
                                            color:  AppColors.kBlack,
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("NO",
                                          style: AppFontStyles.headlineMedium(
                                            fontSize: 14,
                                            color:  AppColors.kBlack,
                                          )),
                                    ),
                                  ],
                                  actionsAlignment:
                                  MainAxisAlignment.spaceAround,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: _buildCard(
                      image:selectedIndex == 4?AppImages.yellowLogout:AppImages.logout, label: 'LOGOUT',index: 4
                    ),
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
                    _showDeleteDialog(context);
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

 /* Widget _buildCard({
    required String image,
    required String label,
    required int index
  }) {
    return Container(
      width: 140,
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
        width: 140,
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
  }*/
  Widget _buildCard({
    required String image,
    required String label,
    required int index,
  }) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45; // 40% of screen width
    double cardHeight = MediaQuery.of(context).size.height * 0.15; // 15% of screen height

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.kRed, AppColors.kRed1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              selectedIndex == index ? AppColors.kRed : AppColors.kWhite,
              selectedIndex == index ? AppColors.kRed1 : AppColors.kWhite,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(image)),
            const SizedBox(height: 10),
            Center(
              child: Text(
                label,
                style: AppFontStyles.headlineMedium(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: selectedIndex == index ? AppColors.kWhite : AppColors.kBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _showDeleteDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {

      return  BlocListener<DeleteAccountBloc, DeleteAccountState>(
          listener: (context, state) {
            if (state is DeleteAccountLoading) {
              // Set the flag to true to show CircularProgressIndicator
              setState(() {
                isLoggingOut = true;
              });
            } else if (state is DeleteAccountSuccess) {
              // Reset the flag and navigate to login page
              setState(() {
                isLoggingOut = false;
              });
              _showYesDialog(context);
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const LoginScreen(),
              //   ),
              // );
            } else if (state is DeleteAccountFailure) {
              // Reset the flag and show an error message
              setState(() {
                isLoggingOut = false;
              });
            //  Navigator.of(context).pop(); // Close the current dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: StatefulBuilder(
            builder: (context, setState) {
              return isLoggingOut
                    ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kBlack,
                    ))
                    :BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppImages.delete,color: AppColors.kRed,),
                          const SizedBox(height: 16),
                          Text(
                            "Are you sure you want to delete this Account?",
                            textAlign: TextAlign.center,
                            style: AppFontStyles.headlineMedium(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  context.read<DeleteAccountBloc>().add(
                                    DeleteAccountButtonPressed(),
                                  );


                                },
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  // padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color:AppColors.kGreen,
                                  ),
                                  // style: ElevatedButton.styleFrom(
                                  //   backgroundColor: Colors.green,
                                  // ),
                                  // onPressed: () {
                                  //   // Handle Yes Action
                                  //   Navigator.of(context).pop();
                                  // },
                                  child:  Center(
                                    child: Text("Yes", style: AppFontStyles.headlineMedium(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kWhite
                                    ),),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  // padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color:AppColors.kRed,
                                  ),
                                  // style: ElevatedButton.styleFrom(
                                  //   backgroundColor: Colors.green,
                                  // ),
                                  // onPressed: () {
                                  //   // Handle Yes Action
                                  //   Navigator.of(context).pop();
                                  // },
                                  child:  Center(
                                    child: Text("No", style: AppFontStyles.headlineMedium(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kWhite
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // contentPadding: const EdgeInsets.only(top: 8),
                // buttonPadding: EdgeInsets.zero,
                // actionsPadding: const EdgeInsets.only(bottom: 10),
                // actions: isLoggingOut
                //     ? []
                //     : <Widget>[
                //   TextButton(
                //     onPressed: () async {
                //       context.read<LogoutBloc>().add(
                //         LogoutButtonPressed(
                //           deviceToken:deviceToken.toString(),
                //         ),
                //       );
                //     },
                //     child: Text("YES",
                //         style: AppFontStyles.headlineMedium(
                //           fontSize: 14,
                //           color:  AppColors.kBlack,
                //         )),
                //   ),
                //   TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: Text("NO",
                //         style: AppFontStyles.headlineMedium(
                //           fontSize: 14,
                //           color:  AppColors.kBlack,
                //         )),
                //   ),
                // ],
                // actionsAlignment:
                // MainAxisAlignment.spaceAround,

            },
          ),
        );



      },
    ).whenComplete(() =>   selectedIndex = 0,);}

  Future<void> _showYesDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppImages.delete,color: AppColors.kRed,),
                  const SizedBox(height: 16),
                  Text(
                    "Your account has been successfully deleted ",
                    textAlign: TextAlign.center,
                    style: AppFontStyles.headlineMedium(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),
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
                            25.0), // Match button's border radius
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                          // Action for booking
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          // Set transparent as the background
                          shadowColor: Colors.transparent,
                          // Remove default button shadow
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Match border radius
                          ),
                        ),
                        child: Text(
                          'OK',
                          style: AppFontStyles.headlineMedium(
                            color: AppColors.kWhite,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() =>   selectedIndex = 0,);}
}
