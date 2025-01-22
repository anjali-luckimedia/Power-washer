import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/home_data/home_data_bloc.dart';
import 'package:power_washer/blocs/home_data/home_data_event.dart';
import 'package:power_washer/blocs/home_data/home_data_state.dart';
import 'package:power_washer/screen/notification_screen.dart';
import 'package:power_washer/screen/search_screen.dart';
import 'package:power_washer/screen/service_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../utils/app_common/Bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  int isSelectedBooking ;

   HomeScreen({required this.isSelectedBooking,Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(LoadHomePageData());

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body: SafeArea(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.kBlack,));
            } else if (state is HomePageLoaded) {
              final homeData = state.homeDataModel;

              return  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                         children: [
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              Text(
                                homeData.data!.header!.location!.address
                                    .toString(),
                                style: AppFontStyles.headlineMedium(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.kBlack),
                              ),
                              Text(homeData.data!.header!.location!.area
                                  .toString(),
                                style: AppFontStyles.headlineMedium(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.kBlack),),
                            ],
                           ),
                           Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen(),
                                    ));
                              },
                              child: FaIcon(FontAwesomeIcons.solidBell))
                        ],
                       ),
                      SizedBox(height: 30,),
                      CommonTextFormField(
                        errorTextColor: AppColors.kBlack,
                        controller: searchController,
                        hintText: AppString.search,
                        borderColor: true,
                        prefixIcon: Icon(Icons.search, color: AppColors.kBlack,size: 30,),
                        readOnly : true, // Prevents the keyboard from opening
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                        },
                      ),
                      SizedBox(height: 0,),
                      CarouselSlider(

                        options: CarouselOptions(
                          height: 180.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),

                        items: homeData.data!.banner!.carousel!.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode
                                            .saturation, // Applies grayscale effect
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Preserve rounded corners
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: Image.asset(
                                        AppImages.bannerOverlay,
                                        fit: BoxFit.cover,
                                      )),

                                  // Text Overlay
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 45,),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            homeData.data!.banner!.title
                                                .toString(),
                                            style: AppFontStyles.headlineMedium(
                                              color: AppColors.kWhite,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          homeData.data!.banner!.subtitle
                                              .toString(),
                                          style: AppFontStyles.headlineMedium(
                                            color: AppColors.kWhite,
                                            fontSize: 38.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          homeData.data!.banner!.description
                                              .toString(),
                                          style: AppFontStyles.headlineMedium(
                                            color: AppColors.kWhite,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // "BOOK NOW!" Button
                                  Positioned(
                                    bottom: 16.0,
                                    right: 16.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.kRed1,
                                            AppColors.kRed
                                          ], // Define your gradient colors
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            30.0), // Match button's border radius
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
                                              horizontal: 16.0, vertical: 12.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // Match border radius
                                          ),
                                        ),
                                        child: Text(
                                          'BOOK NOW!',
                                          style: AppFontStyles.headlineMedium(
                                            color: AppColors.kWhite,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: homeData.data!.banner!.carousel!.asMap().entries.map((entry) {
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          _currentIndex = entry.key;
                                        }),
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentIndex == entry.key
                                                ? AppColors.kRed
                                                : AppColors.kLightRed, // Active dot is red, others are grey
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        AppString.services
                            .toString(),
                        style: AppFontStyles.dinTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.kBlack),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 100, // Adjust the height of the row as needed
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeData
                              .data!.sections!.first.sectionsItems!.length,
                          itemBuilder: (context, index) {
                            final service = homeData.data!.sections!.first.sectionsItems![index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(serviceName:service.name! ,),));
                              },
                              child: _buildPressureWashCard(
                                iconPath: service.icon!,
                                title: service.name!,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        AppString.mostBookedServices
                            .toString(),
                        style: AppFontStyles.dinTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.kBlack),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 200, // Adjust the height of the row as needed
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeData.data!.bookServices!.first
                              .bookServicesItems!.length,
                          itemBuilder: (context, index) {
                            final service = homeData.data!.bookServices!.first
                                .bookServicesItems![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMostBookedServicesCard(
                                    iconPath: service.image!,
                                  ),
                                  SizedBox(height: 8),
                                  // Space between the image and the text
                                  Container(
                                    width: 160, // Adjust width to match design
                                    child: Text(
                                      service.name.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyles.headlineMedium(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kBlack),
                                    ),
                                  ),
                                  Text(
                                    service.servicesType.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFontStyles.headlineMedium(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.kGrey),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star, // Star icon
                                        color: AppColors.kYellow,
                                        size: 16, // Adjust size to match design
                                      ),
                                      SizedBox(width: 4),
                                      // Spacing between star and rating
                                      Text(
                                        service.details!.rating.toString(),
                                        // Rating and reviews
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kBlack),
                                      ),
                                      SizedBox(width: 8),
                                      // Spacing between rating and years
                                      Text(
                                        service.details!.year.toString(),
                                        style: AppFontStyles.headlineMedium(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.kGrey,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      // Spacing between years and distance
                                      Text(
                                        service.details!.time.toString(),
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kBlack),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        AppString.thoughtfulCuration
                            .toString(),
                        style: AppFontStyles.dinTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.kBlack),
                      ),
                      Text(
                        AppString.thoughtfulCuration1
                            .toString(),
                        style: AppFontStyles.headlineMedium(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.kBlack),
                      ),

            ],
                  ),
                ),
              );
            } else if (state is HomePageError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }


  Widget _buildPressureWashCard({
    required String iconPath,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.kRed1, AppColors.kRed], // Define your gradient colors here
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(2), // Adding padding for the border effect
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the content area
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(iconPath, width: 50, height: 50)),
              SizedBox(width: 10),
              Center(
                child: Container(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 0,),
                      Text(
                        title,
                        style: AppFontStyles.headlineMedium(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColors.kBlack,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildMostBookedServicesCard({
    required String iconPath,
  }) {
    return Container(
     // Adjust card width
      //height: 120, // Adjust card height
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the content area
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        iconPath,
        fit: BoxFit.cover,
        width: 170,
      ),
    );
  }
}
