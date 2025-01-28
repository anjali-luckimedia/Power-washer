import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_common/Bottom_navigation.dart';
import '../utils/app_common/app_common_horizontal_video.dart';

class HomeScreen extends StatefulWidget {
  int isSelectedBooking ;

   HomeScreen({required this.isSelectedBooking,Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);
  String latitude = '';
  String longitude = '';
  late SharedPreferences preferences;
  String address = 'Fetching address...'; // Address state variable
  String address1 = 'Fetching address...'; // Address state variable

  @override
  void initState() {
    initPreference();
    // TODO: implement initState
    super.initState();
  }

  void initPreference() async {
    preferences = await SharedPreferences.getInstance();

    // Retrieve the values from SharedPreferences
    final latValue = preferences.get(AppString.kPLatitude);
    final longValue = preferences.get(AppString.kPLongitude);

    // Safely cast or convert to String
    latitude = latValue != null ? latValue.toString() : 'N/A';
    longitude = longValue != null ? longValue.toString() : 'N/A';

    // Print all the values
    print('latitude: $latitude');
    print('longitude: $longitude');
    fetchAddress();
    setState(() {});
  }



  Future<void> fetchAddress() async {
    try {
      if (latitude != '0.0' && longitude != '0.0') {
        double lat = double.parse(latitude);
        double lon = double.parse(longitude);

        // Use the Geocoding plugin to get the address
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            address = '${place.street}, ';
            address1 = '${place.locality}, ${place.administrativeArea}, ${place.country} ';
          });
        } else {
          setState(() {
            address = 'No address found.';
            address1 = 'No address found.';
          });
        }
      } else {
        setState(() {
          address = 'Invalid coordinates.';
          address1 = 'Invalid coordinates.';
        });
      }
    } catch (e) {
      setState(() {
        address = 'Error fetching address: $e';
        address1 = 'Error fetching address: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(LoadHomePageData(latitude,longitude));

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body: SafeArea(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Skeleton for the header
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // Skeleton for the search bar
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 15),

                      // Skeleton for the carousel
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 15),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      // Skeleton for the services section

                      SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 160,
                                        // Match design
                                        height: 20,
                                        // Placeholder height for the service name
                                        color: Colors.grey
                                            .shade300, // Background color for shimmer
                                      ),
                                      SizedBox(height: 8), // Spacing
                                      Container(
                                        width: 120,
                                        // Match design
                                        height: 14,
                                        // Placeholder height for service description
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 8), // Spacing
                                      Row(
                                        children: [
                                          Container(
                                            width: 16,
                                            // Placeholder for star icon
                                            height: 16,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(width: 4),
                                          // Spacing between star and rating
                                          Container(
                                            width: 40, // Placeholder for rating
                                            height: 14,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(width: 8),
                                          // Spacing between rating and years
                                          Container(
                                            width: 50,
                                            // Placeholder for years of experience
                                            height: 14,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(width: 8),
                                          // Spacing between years and distance
                                          Container(
                                            width: 50, // Placeholder for distance
                                            height: 14,
                                            color: Colors.grey.shade300,
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                })),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
           /*   return Center(child: CircularProgressIndicator(color: AppColors.kBlack,));*/
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
                                address
                                    .toString(),
                                style: AppFontStyles.headlineMedium(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.kBlack),
                              ),
                              Text(address1
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
                      SizedBox(height: 15,),

                CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      currentIndexNotifier.value = index; // Update ValueNotifier
                    },
                  ),
                  items: homeData.data!.banners!.map((imagePath) {
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0), // Preserve rounded corners
                                // child: CachedNetworkImage(
                                //   imageUrl: imagePath.image.toString(),
                                //   fit: BoxFit.cover,
                                //  // placeholder: (context, url) => CircularProgressIndicator(),
                                //   errorWidget: (context, url, error) => Icon(Icons.error),
                                // ),
                                child: Image.network(
                                  imagePath.image.toString(),
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(

                                  AppImages.bannerOverlay,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            // Text Overlay
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      imagePath.title.toString(),
                                      style: AppFontStyles.headlineMedium(
                                        color: AppColors.kWhite,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    imagePath.highlight.toString(),
                                    style: AppFontStyles.headlineMedium(
                                      color: AppColors.kWhite,
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    imagePath.caption.toString(),
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
                                  borderRadius: BorderRadius.circular(30.0), // Match button's border radius
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Action for booking
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0), // Match border radius
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
                            // Dots Indicator with ValueListenableBuilder
                            ValueListenableBuilder<int>(
                              valueListenable: currentIndexNotifier,
                              builder: (context, currentIndex, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: homeData.data!.banners!.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () {
                                        currentIndexNotifier.value = entry.key; // Update currentIndex
                                      },
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentIndex == entry.key
                                              ? AppColors.kRed
                                              : AppColors.kLightRed, // Active dot is red, others are grey
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
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
                              .data!.services!.length,
                          itemBuilder: (context, index) {
                            final service = homeData.data!.services![index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(serviceName:service.name! ,),));
                              },
                              child: _buildPressureWashCard(
                                iconPath: service.image!,
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
                          itemCount: homeData.data!.mostBookedServices!.length,
                          itemBuilder: (context, index) {
                            final service = homeData.data!.mostBookedServices![index];
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
                                    service.services.toString(),
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
                                        service.rating.toString(),
                                        // Rating and reviews
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kBlack),
                                      ),
                                      SizedBox(width: 8),
                                      // Spacing between rating and years
                                      Text(
                                        service.yearsOfExperience.toString(),
                                        style: AppFontStyles.headlineMedium(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.kGrey,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      // Spacing between years and distance
                                      Text(
                                        service.distance.toString(),
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
                      SizedBox(height: 10,),
                      Container(height:225,child: HorizontalVideoList()),
                      SizedBox(height: 10,),
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
              Center(child: SvgPicture.network(iconPath, width: 50, height: 50)),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.kRed,width: 2)),
     // Adjust card width
      //height: 120, // Adjust card height
      // decoration: BoxDecoration(
      //   color: Colors.white, // Background color of the content area
      //   borderRadius: BorderRadius.circular(8),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.3),
      //       blurRadius: 5,
      //       offset: Offset(0, 3),
      //     ),
      //   ],
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: iconPath.toString(),
          width: 170,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(height:30,width: 30,child: Center(child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // child: Image.network(
        //   iconPath,
        //   fit: BoxFit.cover,
        //   width: 170,
        // ),
      ),
    );
  }
}
