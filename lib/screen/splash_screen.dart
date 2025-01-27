import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/screen/splash_screen_2.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import '../utils/app_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initPreference();
  }

  void initPreference() async {
    prefs = await SharedPreferences.getInstance();
    await getLoggedInState();
    navigateToScreen();
    await determinePosition();

  }

  Future<void> getLoggedInState() async {
    isLoggedIn = prefs.getBool(AppString.kIsLoggedIn) ?? false;
    setState(() {});
    print('isLoggedIn: $isLoggedIn'); // Debug statement
  }

  /*Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled; don't continue
      // accessing the position and request users to enable the location services.
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied; next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines,
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever; handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted, and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    // Save the latitude and longitude to SharedPreferences
    await prefs.setDouble(AppString.kPLatitude, position.latitude);
    await prefs.setDouble(AppString.kPLongitude, position.longitude);
  }*/
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are disabled, return or prompt the user to enable it
      print('Location services are disabled.');
      Geolocator.openLocationSettings(); // Opens location settings for the user
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, cannot request permissions.');
      return;
    }

    // If permissions are granted, fetch the location
    Position position = await Geolocator.getCurrentPosition();
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    await prefs.setDouble(AppString.kPLatitude, position.latitude);
    await prefs.setDouble(AppString.kPLongitude, position.longitude);
  }

  void navigateToScreen() {
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(isSelectedBooking: 0)),
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
          Container(
              width: double.infinity,
              child: Image.asset(
                AppImages.splashImage,
                fit: BoxFit.cover,
              )),
          Container(
              width: double.infinity,
              child: Image.asset(
                AppImages.bgImage,
                fit: BoxFit.cover,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoImage,
                scale: 6.0,
              ),
              Image.asset(
                AppImages.gotDirtImage,
                scale: 6.0,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  AppImages.locatorImage,
                  scale: 6.0,
                ),
                SizedBox(height: 8),
                Text(
                  'locator',
                  style: AppFontStyles.headlineMedium(
                      color: AppColors.kWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
