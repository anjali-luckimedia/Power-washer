import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/service/service_data_bloc.dart';
import 'package:power_washer/blocs/service/service_data_event.dart';
import 'package:power_washer/screen/service_details_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_common_appbar.dart';
import 'package:power_washer/utils/app_common/app_common_btn.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/service/service_data_state.dart';
import '../utils/app_common/app_common_widget.dart';

class ServiceScreen extends StatefulWidget {
  String? serviceName;
   ServiceScreen({Key? key,this.serviceName}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  TextEditingController searchController = TextEditingController();

  double _currentDistance = 2; // Initial distance value
  int _selectedRating = 5; // Initial rating value
  String latitude = '';
  String longitude = '';
  late SharedPreferences preferences;
  int selectedTab = 0;


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

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    context.read<ServicePageBloc>().add(LoadServicePageData(latitude,longitude));
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,

        title: widget.serviceName!,
        iconData: Icons.arrow_back,
        faIcon: FaIcon(
          FontAwesomeIcons.filter,
          color: AppColors.kBlack,
          size: 20,
        ),
        onBackTap: (){
          Navigator.pop(context);
        },
        onActionTap: _modalBottomSheetMenu,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
        child: Column(
          children: [

            Divider(color: AppColors.kLightGrey,thickness: 1,),
            Container(
              height: 45,
              width: 170,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.kRed, AppColors.kRed1], // Define your gradient colors here
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              ),
              padding: EdgeInsets.all(1),
              child: Container(
                height: 45,
                width: 170,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  border: Border.all(color: AppColors.kWhite, width: 1),
                ),
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 82,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          gradient: LinearGradient(
                            colors: [
                              selectedTab == 0 ?AppColors.kRed :AppColors.kWhite,
                              selectedTab == 0 ? AppColors.kRed1 :AppColors.kWhite
                            ], // Define your gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          // color: selectedTab == 0 ? AppColors.kGreen : AppColors.kDarkGrey,

                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            selectedTab == 0?AppImages.whiteServiceImage : AppImages.serviceImage,
                          ),
                          // child: Text(
                          //   'FIXTURE',
                          //   style: AppFontStyles.titleLarge(
                          //     color: selectedTab == 0 ? AppColors.kBlack : AppColors.kWhite,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(width: 0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 82,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              selectedTab == 1 ?AppColors.kRed :AppColors.kWhite,
                              selectedTab == 1 ? AppColors.kRed1 :AppColors.kWhite
                            ], // Define your gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            selectedTab == 1?AppImages.whiteMapImage :AppImages.mapImage,),
                          // child: Text(
                          //   'FIXTURE',
                          //   style: AppFontStyles.titleLarge(
                          //     color: selectedTab == 0 ? AppColors.kBlack : AppColors.kWhite,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ServicePageBloc, ServicePageState>(
                builder: (context, state) {
                  if (state is ServicePageLoading) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image skeleton
                                Container(
                                  height: 90,
                                  width: 124,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                SizedBox(width: 8),
                                // Details skeleton
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 150,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 10,
                                        width: 200,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 14,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 14,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Container(
                                              height: 10,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                   // return Center(child: CircularProgressIndicator());
                  } else if (state is ServicePageLoaded) {

                    return state.serviceModel.data!.isNotEmpty?ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.serviceModel.data!.length,
                      itemBuilder: (context, index) {
                        final item = state.serviceModel.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailsScreen( serviceId: item.serviceId.toString(),),));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image Section
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                      Border.all(color: AppColors.kRed)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        item.image!,
                                        height: 90,
                                        width: 124,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, url, error) =>Image.asset('assets/images/mostBookesImage.png',height: 85,
                                          width: 124,
                                          fit: BoxFit.cover,)
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                // Details Section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   item.serviceId.toString(),
                                      //   style: AppFontStyles.headlineMedium(
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: AppColors.kBlack
                                      //   ),
                                      // ),
                                      // Title
                                      Text(
                                        item.name.toString(),
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kBlack
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      // Address
                                      Row(
                                        children: [
                                          FaIcon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 14,
                                              color: AppColors.kBlack),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item.address.toString(),
                                              style: AppFontStyles.headlineMedium(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.kGrey
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      // Service Description
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppImages.category,height: 13,),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item.services.toString(),
                                              style: AppFontStyles.headlineMedium(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.kGrey
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      // Rating and Years
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 14, color: AppColors.kYellow),
                                          Text(
                                            ' ${item.rating.toString()}.0 (${item.reviews})',
                                            style: AppFontStyles.headlineMedium(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.kBlack
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              '${item.yearsOfExperience}',
                                              // maxLines: 1,
                                              style: AppFontStyles.headlineMedium(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.kGrey,

                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Distance Section
                                Column(
                                  children: [
                                    Text(
                                      item.distance.toString(),
                                      style: AppFontStyles.headlineMedium(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kBlack
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                        // return ListTile(
                        //   title: Text(item.name.toString()), // Adjust per API response
                        // );
                      },
                    ):CommonWidget().commonNoData(context);
                  } else if (state is ServicePageError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text('Start typing to search...'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(){
      showModalBottomSheet(
       backgroundColor: AppColors.kWhite,
      context: context,
      isScrollControlled: true, // Makes modal take full height if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:(context) {
        return StatefulBuilder(
          builder: (context, snapshot) {
            return Container(
              height: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0,top: 5),
                        child: GestureDetector(child: Icon(Icons.close, color: Colors.black,size: 18,),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),

                  Center(
                    child: Text(
                      AppString.filterBy,
                      style: AppFontStyles.dinTextStyle(color: AppColors.kBlack, fontWeight: FontWeight.bold,fontSize: 22),

                    ),
                  ),
                  Divider(color: AppColors.kLightGrey,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CommonTextFormField(
                            errorTextColor: AppColors.kBlack,
                            controller: searchController,
                            hintText: AppString.search,
                            borderColor: true,
                            prefixIcon: Icon(Icons.search, color: AppColors.kBlack,size: 30,),
                            onTap: (){

                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        // Distance Filter
                        Text(
                          AppString.miles,
                          style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w600, fontSize: 18,color: AppColors.kBlack),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 2,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                            activeTrackColor: Colors.red,
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: Colors.red,
                            valueIndicatorColor: Colors.red,
                          ),
                          child: Slider(
                            value: _currentDistance,
                            min: 2,
                            max: 10,
                            divisions: 8,
                            label: "${_currentDistance.toInt()} miles",
                            onChanged: (value) {
                              // Handle state change
                              _currentDistance = value;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("02 miles"),
                            Text("10 miles"),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(color: AppColors.kLightGrey,thickness: 1,),
                        // Rating Filter
                        Text(
                          AppString.rating,
                          style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w600, fontSize: 18,color: AppColors.kBlack),

                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            int rating = index + 1;
                            return GestureDetector(
                              onTap: () {
                                // Handle rating selection
                                _selectedRating = rating;
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 8,left: 8,top: 0,bottom: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [
                                      _selectedRating == rating ? AppColors.kRed :AppColors.kWhite,
                                      _selectedRating == rating ? AppColors.kRed1:AppColors.kWhite,

                                    ], // Define your gradient colors
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  //color: _selectedRating == rating ? Colors.red : Colors.white,
                                  border: Border.all(
                                    color: _selectedRating == rating ? Colors.red : Colors.grey,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "$rating",
                                      style: AppFontStyles.headlineMedium(
                                        color: _selectedRating == rating ? AppColors.kWhite : AppColors.kBlack,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),

                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: _selectedRating == rating ? AppColors.kWhite : AppColors.kYellow,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 40),

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
                                AppString.apply.toUpperCase(),
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

                ],
              ),
            );
          }
        );
      },
    );
  }


}
