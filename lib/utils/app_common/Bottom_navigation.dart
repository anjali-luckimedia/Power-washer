import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_washer/screen/home_screen.dart';
import 'package:power_washer/screen/my_request_screen.dart';
import 'package:power_washer/screen/profile_screen.dart';
import 'package:power_washer/screen/setting_screen.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import '../app_colors.dart';

class BottomNavigation extends StatefulWidget {
  int? currentIndex;

  BottomNavigation({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<bool> _isActive = [true, false, false, false]; // Initial active state

  final List<Widget> _pages = [
    HomeScreen(isSelectedBooking: 0,),
    MyRequestScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentIndex();
  }

  Future<void> _loadCurrentIndex() async {
    setState(() {
      _isActive = List<bool>.generate(4, (index) => index == widget.currentIndex); // Mark current index as active
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x54000000),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.kWhite,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex!,
          selectedItemColor: AppColors.kRed, // Color for selected label and icon
          unselectedItemColor: AppColors.kBlack, // Color for unselected label and icon
          iconSize: 30, // Adjust icon size

          selectedLabelStyle: AppFontStyles.headlineMedium(
            color: AppColors.kRed,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: AppFontStyles.headlineMedium(
            color: AppColors.kBlack,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          showUnselectedLabels: true,
          showSelectedLabels: true,

          items: [
            BottomNavigationBarItem(


             icon: _buildIcon(AppImages.bottomHomeImage, 0),

             //icon: _buildIcon(FontAwesomeIcons.home, 0),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(AppImages.bottomMyRequestImage, 1),
              //icon: _buildIcon(FontAwesomeIcons.calendar, 1),
              label: 'MY REQUEST',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(AppImages.bottomSettingImage, 2),
              //icon: _buildIcon(FontAwesomeIcons.gear, 2),
              label: "SETTINGS",
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(AppImages.bottomProfileImage, 3),
              //icon: _buildIcon(FontAwesomeIcons.solidUserCircle, 3),
              label: 'PROFILE',
            ),
          ],
          onTap: (int i) {
            if (i != widget.currentIndex) {
              setState(() {
                widget.currentIndex = i;
                for (int index = 0; index < _isActive.length; index++) {
                  _isActive[index] = (index == i);
                }
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => _pages[i]),
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method to build an icon with dynamic color based on active state
  Widget _buildIcon(String assetPath, int index) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _isActive[index] ? AppColors.kRed : AppColors.kBlack, // Active color or inactive color
        BlendMode.srcIn,
      ),
      child: index == 3
          ? FaIcon(
              FontAwesomeIcons.solidUserCircle,

              color: _isActive[index] ? AppColors.kRed : AppColors.kBlack,
              size: 30,

            )
          : SvgPicture.asset(
              assetPath,
              width: 30,
        height: 30,
            ),
    );
  }
/*  Widget _buildIcon(IconData iconData, int index) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _isActive[index] ? AppColors.kRed : AppColors.kBlack, // Active color or inactive color
        BlendMode.srcIn,
      ),
      child:  SvgPicture.asset(
        'assets/images/booking.svg',)



    );
  }*/

}
