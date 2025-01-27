import 'dart:ui';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_washer/blocs/add_booking/add_booking_bloc.dart';
import 'package:power_washer/blocs/gallery/gallery_data_bloc.dart';
import 'package:power_washer/blocs/gallery/gallery_data_event.dart';
import 'package:power_washer/blocs/review/review_data_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_event.dart';
import 'package:power_washer/model/service_details_model.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_common_widget.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/add_booking/add_booking_event.dart';
import '../blocs/add_booking/add_booking_state.dart';
import '../blocs/add_review/add_review_bloc.dart';
import '../blocs/add_review/add_review_state.dart';
import '../blocs/gallery/gallery_data_state.dart';
import '../blocs/review/review_data_event.dart';
import '../blocs/review/review_data_state.dart';
import '../blocs/service_details/service_details_state.dart';
import '../utils/app_common/app_dialog_add_review.dart';

class ServiceDetailsScreen extends StatefulWidget {
  String serviceId;
   ServiceDetailsScreen({Key? key,required this.serviceId}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {

  //int selectedIndex = -1;
// Set<int> selectedIndex = {};
  ValueNotifier<List<int>> selectedIndex = ValueNotifier<List<int>>([]); // Ensure ';' is present

  final ValueNotifier<bool> isGalleryShowNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAddBookingLoader = ValueNotifier<bool>(false);
  String latitude = '';
  String longitude = '';
  late SharedPreferences preferences;
 // bool isAddBookingLoader = false;

  @override
  void initState() {
    context.read<ServiceDetailsBloc>().add(LoadServiceDetailsData(widget.serviceId,latitude,longitude));

    print('----${widget.serviceId.toString()}');
    initPreference();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // Dispose ValueNotifier to avoid memory leaks
    selectedIndex.dispose();
    isGalleryShowNotifier.dispose();
    isAddBookingLoader.dispose();
    super.dispose();
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
     return Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body:  BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
        builder: (context, state) {
          if (state is ServiceDetailsLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: 100,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Row(
                        children: [
                          Container(width: 15, height: 15, color: Colors.grey[300]),
                          SizedBox(width: 10),
                          Container(width: 200, height: 15, color: Colors.grey[300]),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
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
                    SizedBox(height: 30,),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
           // return Center(child: CircularProgressIndicator());
          } else if (state is ServiceDetailsLoaded) {
            final serviceData = state.serviceDetailsModel;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          if (serviceData.data!.imageSection!.image!.type
                                  .toString() ==
                              '2') ...[
                            Image.asset(
                              'assets/images/car-wash.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height:
                                  250, // Ensure a defined height for the image
                            ),
                          ] else ...[
                            Image.network(
                              serviceData.data!.imageSection!.image!.fileUrl
                                  .toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height:
                                  250, // Ensure a defined height for the image
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0, left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.kRed,
                                      AppColors.kRed1
                                    ], // Define your gradient colors here
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 180.0, left: 5, right: 5),
                            child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.kWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: serviceData.data!.imageSection!
                                              .gallery!.length >
                                          6
                                      ? 6 // Show only the first 6 items
                                      : serviceData.data!.imageSection!.gallery!
                                          .length, // Show all if less than 6
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    print(serviceData.data!.imageSection!
                                        .gallery![index].fileUrl);

                                    // Check if it's the last index being displayed (index == 5) and total items exceed 6
                                    if (index == 5 &&
                                        serviceData
                                                .data!
                                                .imageSection!
                                                .gallery![index]
                                                .fileUrl!
                                                .length >
                                            6) {
                                      return GestureDetector(
                                        onTap: () {
                                          isGalleryShowNotifier.value = !isGalleryShowNotifier.value;
                                          context.read<GalleryBloc>().add(
                                              LoadGalleryData(
                                                  widget.serviceId));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 52,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                  ),
                                                  child: serviceData
                                                              .data!
                                                              .imageSection!
                                                              .gallery![index]
                                                              .type
                                                              .toString() ==
                                                          '2'
                                                      ? Stack(
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/car-wash.png',
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                              height:
                                                                  250, // Ensure a defined height for the image
                                                            ),
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child: Container(
                                                                height: 40,
                                                                width: 52,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                // Semi-transparent overlay
                                                                child: Center(
                                                                    child: IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon: Icon(
                                                                            Icons.play_arrow))),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Image.network(
                                                          serviceData
                                                              .data!
                                                              .imageSection!
                                                              .gallery![index]
                                                              .fileUrl
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              // Add an overlay for the last item
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 52,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  // Semi-transparent overlay
                                                  child: Center(
                                                    child: Text(
                                                      "+${serviceData.data!.imageSection!.count}",
                                                      // Remaining items count

                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    // Regular container for non-last indices
                                    return Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        // Set the radius as desired
                                        child: Container(
                                          height: 40,
                                          width: 52,
                                          child: serviceData.data!.imageSection!
                                                      .gallery![index].type
                                                      .toString() ==
                                                  '2'
                                              ? Stack(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/car-wash.png',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height:
                                                          250, // Ensure a defined height for the image
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Container(
                                                        height: 40,
                                                        width: 52,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        // Semi-transparent overlay
                                                        child: Center(
                                                            child: IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                  Icons
                                                                      .play_arrow_outlined,
                                                                  color: AppColors
                                                                      .kWhite,
                                                                  size: 35,
                                                                ))),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Image.network(
                                                  serviceData
                                                      .data!
                                                      .imageSection!
                                                      .gallery![index]
                                                      .fileUrl
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height:
                                                      250, // Ensure a defined height for the image
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              serviceData.data!.serviceDetails!.name.toString(),
                              style: AppFontStyles.headlineMedium(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                serviceData.data!.serviceDetails!.distance
                                    .toString(),
                                style: AppFontStyles.headlineMedium(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              serviceData.data!.serviceDetails!.location
                                  .toString(),
                              style: AppFontStyles.headlineMedium(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              size: 15,
                              color: AppColors.kYellow,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              serviceData.data!.serviceDetails!.rating!.score
                                  .toString(),
                              style: AppFontStyles.headlineMedium(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _viewAll(serviceData);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'View all',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      // decoration: TextDecoration.underline,
                                      //   decorationThickness: 4,
                                      //   color: AppColors.kBlack
                                    ),
                                  ),
                                  //SizedBox(height: 1,),
                                  Container(
                                    height: 1,
                                    width: 50,
                                    color: AppColors.kBlack,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              AppImages.yearImage,
                              width: 15,
                              height: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              serviceData.data!.serviceDetails!.experience
                                  .toString(),
                              style: AppFontStyles.headlineMedium(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Text(
                          'Description',
                          style: AppFontStyles.headlineMedium(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Text(
                          serviceData.data!.serviceDetails!.description
                              .toString(),
                          style: AppFontStyles.headlineMedium(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Text(
                          'Services',
                          style: AppFontStyles.headlineMedium(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 110,
                        child: ValueListenableBuilder<List<int>>(
                          valueListenable: selectedIndex,
                          builder: (context, selectedIndexValue, _) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: serviceData.data!.services!.length,
                              itemBuilder: (context, index) {
                                final service = serviceData.data!.services![index];
                                final categoryId = int.parse(service.categoryId.toString());

                                return GestureDetector(
                                  onTap: () {
                                    // Update selectedIndex
                                    if (selectedIndex.value.contains(categoryId)) {
                                      selectedIndex.value = List<int>.from(selectedIndex.value)..remove(categoryId);
                                    } else {
                                      selectedIndex.value = List<int>.from(selectedIndex.value)..add(categoryId);
                                    }
                                    selectedIndex.notifyListeners(); // Ensure listeners are notified after updating.

                                    // Notify listeners
                                    selectedIndex.notifyListeners();
                                  },
                                  child: _buildPressureWashCard(
                                    iconPath: service.image.toString(),
                                    title: service.name.toString(),
                                    index: index,
                                    isSelected: selectedIndexValue.contains(categoryId),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      BlocConsumer<AddBookingBloc, AddBookingState>(
                        listener: (context, state) {
                          if (state is AddBookingLoading) {
                            isAddBookingLoader.value = true;
                          } else if (state is AddBookingSuccess) {
                            isAddBookingLoader.value = false;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.close, color: AppColors.kBlack),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.check_circle_outline,
                                            color: AppColors.kGreen, size: 48.0),
                                        SizedBox(height: 16.0),
                                        Text(
                                          'Thank you!',
                                          style: AppFontStyles.headlineMedium(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Your request has been sent successfully!',
                                          style: AppFontStyles.headlineMedium(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is AddBookingFailure) {
                            isAddBookingLoader.value = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.kRed, AppColors.kRed1],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isAddBookingLoader,
                                builder: (context, isLoading, child) {
                                  return ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                      final serviceId =
                                          serviceData.data!.serviceDetails!.id
                                              .toString() ??
                                              '';
                                      final categories = selectedIndex.value.toSet();
                                      if (serviceId.isEmpty || categories.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please fill in all required fields.'),
                                          ),
                                        );
                                        return;
                                      }
                                      context.read<AddBookingBloc>().add(
                                        AddBookingButtonPressed(
                                          serviceId: serviceId,
                                          categories: categories,
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 45.0,
                                        vertical: 12.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: isLoading
                                        ? CircularProgressIndicator(color: AppColors.kWhite)
                                        : Text(
                                      AppString.request.toUpperCase(),
                                      style: AppFontStyles.headlineMedium(
                                        color: AppColors.kWhite,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<GalleryBloc, GalleryState>(
                  builder: (context, state) {
                   /* if (state is GalleryLoading) {

                      // Show a loading indicator while fetching data
                     return Center(child: CircularProgressIndicator());
                    } else*/ if (state is GalleryLoaded) {
                      // When gallery data is successfully loaded
                      final galleryData = state.galleryModel;

                      return ValueListenableBuilder<bool>(
                        valueListenable: isGalleryShowNotifier,
                        builder: (context, isGalleryShow, child) {
                          return isGalleryShow
                              ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: Column(
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  // Gallery Content
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 90),
                                                Text(
                                                  'The Shine Gallery/videos',
                                                  textAlign: TextAlign.center,
                                                  style: AppFontStyles.headlineMedium(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 18,
                                                    color: AppColors.kWhite,
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    isGalleryShowNotifier.value = false;
                                                  },
                                                  icon: Icon(Icons.close),
                                                  color: AppColors.kWhite,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Divider(
                                                thickness: 2,
                                                color: AppColors.kWhite,
                                              ),
                                            ),
                                            Container(
                                              height: 710,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: GridView.builder(
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns
                                                    mainAxisSpacing: 15.0, // Vertical spacing
                                                    crossAxisSpacing: 20.0, // Horizontal spacing
                                                    childAspectRatio: 1,
                                                  ),
                                                  itemCount: galleryData.data!.length,
                                                  itemBuilder: (context, index) {
                                                    print(galleryData.data!.length);

                                                    final item = galleryData.data![index];
                                                    return ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      child: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Stack(
                                                          children: [
                                                            // The image
                                                            Container(
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  fit: BoxFit.fill,
                                                                  image: item.type == '2'
                                                                      ? AssetImage('assets/images/car-wash.png') as ImageProvider
                                                                      : NetworkImage(item.fileUrl.toString()),
                                                                ),
                                                              ),
                                                            ),

                                                            // Overlay play icon if type == 2
                                                            if (item.type == '2')
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                                child: Container(
                                                                  width: double.infinity,
                                                                  height: double.infinity,
                                                                  color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                                                                  child: Center(
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        // Your action when the play icon is pressed
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.play_arrow_outlined,
                                                                        color: AppColors.kWhite,
                                                                        size: 45, // Adjust icon size as needed
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Wrap();
                        },
                      );
                    } else if (state is GalleryError) {
                      // Handle error state
                      return Center(
                        child: Text(
                          'Failed to load gallery.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      // Default state (e.g., initial state)
                      return Center(
                        child: Text('No data available.',style: TextStyle(color: AppColors.kWhite),),
                      );
                    }
                  },
                ),

              ],
            );
          } else if (state is ServiceDetailsError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Start typing to search...'));
        },
      ),
    );
  }

  Widget _buildPressureWashCard({
    required String iconPath,
    required String title,
    required int index,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
             AppColors.kRed,
             AppColors.kRed1
            ], // Define your gradient colors here
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(2), // Adding padding for the border effect
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isSelected? AppColors.kRed:AppColors.kWhite,
                isSelected? AppColors.kRed1:AppColors.kWhite,
              ], // Define your gradient colors here
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.network(iconPath, width: 50, height: 50)),
              SizedBox(height: 12),
              Container(
                width: 90,
                //color: Colors.red,
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: AppFontStyles.headlineMedium(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color:  isSelected?AppColors.kWhite:AppColors.kBlack,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  void _viewAll(ServiceDetailsModel serviceDetails) {
    context.read<ReviewBloc>().add(LoadReviewData(widget.serviceId)); // Trigger event to fetch reviews

    showModalBottomSheet(
      backgroundColor: AppColors.kWhite,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 450.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 5),
                        child: GestureDetector(
                          child: const Icon(Icons.close, color: Colors.black, size: 18),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      AppString.reviews,
                      style: AppFontStyles.dinTextStyle(
                        color: AppColors.kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.kLightGrey, thickness: 1),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 5),
                        child: GestureDetector(
                          child: SvgPicture.asset(AppImages.editImage),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 5),
                        child: GestureDetector(
                          onTap: (){

                            showDialog(
                              context: context,
                              builder: (context) => AddReviewDialog(serviceDetailsModel: serviceDetails,),
                            );



                          },
                          child: Column(
                            children: [
                              Text(
                                'Add Review',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  // decoration: TextDecoration.underline,
                                  // decorationThickness: 4,
                                  // color: AppColors.kBlack,
                                ),
                              ),

                              //SizedBox(height: 1,),
                              Container(height: 1,width: 95,color: AppColors.kBlack,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'All Reviews',
                      style: AppFontStyles.headlineMedium(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      if (state is ReviewLoading) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: 6, // Adjust the number of shimmer items
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer.fromColors(
                                baseColor: AppColors.kLightGrey,
                                highlightColor: AppColors.kWhite,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppColors.kLightGrey,
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 100,
                                            color: AppColors.kLightGrey,
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            height: 14,
                                            width: 200,
                                            color: AppColors.kLightGrey,
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            height: 14,
                                            width: 150,
                                            color: AppColors.kLightGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      //  return  Center(child: CircularProgressIndicator());
                      } else if (state is ReviewLoaded) {
                        final reviews = state.reviewModel; // List of reviews from the state
                        return reviews.data!.isEmpty?CommonWidget().commonNoData(context):Expanded(
                          child: ListView.builder(
                            itemCount: reviews.data!.length,
                            itemBuilder: (context, index) {
                              final review = reviews.data![index];
                              print(reviews.data!.length,);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                     // alignment: Alignment.center,
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                      ),
                                      padding: EdgeInsets.all(2), // Adding padding for the border effect
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.kWhite,
                                              AppColors.kWhite,

                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                          ),
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                            child: Image.network(review
                                                .profileImage
                                                .toString())),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                review.name.toString(),
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400, fontSize: 16),
                                              ),
                                              Spacer(), // Pushes the next widget to the end
                                              Text(
                                                review.timestamp.toString(),
                                                textAlign: TextAlign.end,
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.kLightGrey),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text(
                                                'Reviews: ',
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 11,),

                                              ),
                                              RatingBar.readOnly(
                                                filledIcon: Icons.star,
                                                halfFilledIcon: Icons.star_half, // Icon for half-filled stars
                                                emptyIcon: Icons.star,
                                                initialRating: review.rating!.toDouble(), // e.g., 4.5
                                                maxRating: 5,
                                                size: 12, // Adjust the star size
                                                filledColor: AppColors.kYellow, // Color for filled stars
                                                emptyColor: AppColors.kStarGrey, // Color for empty stars
                                                isHalfAllowed: true, // Allow half-filled stars
                                              ),

                                              Text(
                                                '(${review.rating.toString()})',
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 11,),

                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' ${review.categories!.first}',
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: AppFontStyles
                                                      .headlineMedium(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Container(
                                              width: 320,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    review.reviewText.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 16,),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(height: 8,),
                                          Container(
                                            width: 320,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors:[
                                                AppColors.kRed,
                                                AppColors.kRed1,

                                                ],)
                                            ),
                                            height: 2,
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is ReviewError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text('No reviews available.'));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


}