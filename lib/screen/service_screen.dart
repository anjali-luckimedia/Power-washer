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

import '../blocs/service/service_data_state.dart';

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
        onActionTap: _modalBottomSheetMenu,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
        child: Column(
          children: [
            /* SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.kBlack,
                      size: 25,
                    )),
                Text(widget.serviceName!,style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w800,fontSize: 18,color: AppColors.kBlack,)),
                GestureDetector(
                    onTap: () {
                        _modalBottomSheetMenu();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.filter,
                      color: AppColors.kBlack,
                      size: 25,
                    )),
              ],
            ),*/
            Divider(color: AppColors.kLightGrey,thickness: 1,),
            Expanded(
              child: BlocBuilder<ServicePageBloc, ServicePageState>(
                builder: (context, state) {
                  if (state is ServicePageLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ServicePageLoaded) {
                    return ListView.builder(
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
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: AppColors.kRed)),
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
                    );
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
