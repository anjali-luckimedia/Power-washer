import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../utils/app_colors.dart';
import '../utils/app_common/Bottom_navigation.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            CommonTextFormField(
              errorTextColor: AppColors.kBlack,
              controller: searchController,
              hintText: AppString.search,
              borderColor: true,
              prefixIcon: Icon(Icons.arrow_back, color: AppColors.kBlack,size: 25,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              },
              suffixIcon: Image.asset(
                AppImages.cancel,
                scale: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
