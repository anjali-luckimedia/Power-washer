import 'package:flutter/material.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/screen/splash_screen_2.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

import '../utils/app_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SharedPreferences prefs;
  bool isLoggedIn = false;
  String role = '';

  @override
  void initState() {
    super.initState();
    initPreference();
  }

  void initPreference() async {
    prefs = await SharedPreferences.getInstance();
    getLoggedInState();
    await requestLocationPermission();
  }

  // Get the logged-in state from SharedPreferences
  getLoggedInState() async {
    isLoggedIn = prefs.getBool(AppString.kIsLoggedIn) ?? false;
    setState(() {
      isLoggedIn = isLoggedIn;
    });
    navigateToScreen();
    print('isLoggedIn: $isLoggedIn'); // Debug statement
  }

  // Request location permission and save location
  Future<void> requestLocationPermission() async {
    Location location = Location();

    // Check if the location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle location service not enabled
        return;
      }
    }

    // Check and request permission
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        // Handle permission not granted
        return;
      }
    }

    // Get current location
    LocationData currentLocation = await location.getLocation();

    // Save the latitude and longitude in SharedPreferences
    prefs.setDouble('latitude', currentLocation.latitude ?? 0.0);
    prefs.setDouble('longitude', currentLocation.longitude ?? 0.0);

    print('Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}');
  }

  // Navigate to the appropriate screen based on the login status
  void navigateToScreen() {
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(isSelectedBooking: 0)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen2()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(width: double.infinity, child: Image.asset(AppImages.splashImage, fit: BoxFit.cover)),
          Container(width: double.infinity, child: Image.asset(AppImages.bgImage, fit: BoxFit.cover)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.logoImage, scale: 6.0),
              Image.asset(AppImages.gotDirtImage, scale: 6.0),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(AppImages.locatorImage, scale: 6.0),
                SizedBox(height: 8),
                Text(
                  'locator',
                  style: AppFontStyles.headlineMedium(
                    color: AppColors.kWhite,
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
