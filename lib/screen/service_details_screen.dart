import 'dart:ui';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_washer/blocs/review/review_data_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_bloc.dart';
import 'package:power_washer/blocs/service_details/service_details_event.dart';
import 'package:power_washer/model/service_details_model.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../blocs/review/review_data_event.dart';
import '../blocs/review/review_data_state.dart';
import '../blocs/service_details/service_details_state.dart';
import '../utils/app_common/app_dialog_add_review.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {

  int selectedIndex = -1;
  bool isGalleryShow = false;

  @override
  Widget build(BuildContext context) {
    context.read<ServiceDetailsBloc>().add(LoadServiceDetailsData());
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body:  BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
        builder: (context, state) {
          if (state is ServiceDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ServiceDetailsLoaded) {
            final serviceData = state.serviceDetailsModel;
            return Stack(
              children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          serviceData.data!.imageSection!.image.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250, // Ensure a defined height for the image
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0, left: 15),
                          child: GestureDetector(
                            onTap: (){
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
                          padding: const EdgeInsets.only(top: 180.0,left: 5,right: 5),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: serviceData.data!.imageSection!.gallery!.length > 6
                                  ? 6 // Show only the first 6 items
                                  : serviceData.data!.imageSection!.gallery!.length, // Show all if less than 6
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // Check if it's the last index being displayed (index == 5) and total items exceed 6
                                if (index == 5 && serviceData.data!.imageSection!.gallery!.length > 6) {
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isGalleryShow = !isGalleryShow;
                                      });
                                    //  showGalleryModal(context, serviceData);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              height: 40,
                                              width: 52,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                              ),
                                              child: Image.asset(
                                                serviceData.data!.imageSection!.gallery![index].toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // Add an overlay for the last item
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              height: 40,
                                              width: 52,
                                              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                                              child: Center(
                                                child: Text(
                                                  "+${serviceData.data!.imageSection!.gallery!.length - 6}", // Remaining items count

                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
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
                                    borderRadius: BorderRadius.circular(8.0), // Set the radius as desired
                                    child: Container(
                                      height: 40,
                                      width: 52,

                                      child: Image.asset(
                                        serviceData.data!.imageSection!.gallery![index].toString(),
                                        fit: BoxFit.cover, // Ensure the image covers the entire container
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )


                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(serviceData.data!.serviceDetails!.name.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.bold,fontSize: 20),)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(serviceData.data!.serviceDetails!.distance.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.bold,fontSize: 12),),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.locationArrow,size: 15,),
                          SizedBox(width: 10,),
                          Text(serviceData.data!.serviceDetails!.location!.address.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 12),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.solidStar,size: 15,color: AppColors.kYellow,),
                          SizedBox(width: 10,),
                          Text(serviceData.data!.serviceDetails!.rating!.score.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 12),),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: (){
                              _viewAll(serviceData);
                            },
                            child: Text(
                              'View all',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                  decorationThickness: 4,
                                  color: AppColors.kBlack
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          SvgPicture.asset(AppImages.yearImage,width: 15,height: 15,),
                          SizedBox(width: 10,),

                          Text(serviceData.data!.serviceDetails!.experience.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 12),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Text('Description',style: AppFontStyles.headlineMedium(fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                      child: Text(serviceData.data!.description!.content.toString(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 16),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Text('Services',style: AppFontStyles.headlineMedium(fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                    SizedBox(
                      height: 125, // Adjust the height of the row as needed

                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceData.data!.services!.length,
                        itemBuilder: (context, index) {
                          final service = serviceData.data!.services![index];
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                if(index == 0){
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                }else if(index == 1){
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                }else if(index == 2){
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                }

                              });
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(serviceName:service.name! ,),));
                            },
                            child: _buildPressureWashCard(
                              iconPath: service.image!,
                              title: service.name!,
                              index: index
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                                horizontal: 45.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Match border radius
                            ),
                          ),
                          child: Text(
                            AppString.request.toUpperCase(),
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
                isGalleryShow ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Column(
                      children: [
                      //  SizedBox(height: 30,),
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
                            decoration:  BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0,),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 90,),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'The Shine Gallery/videos',
                                        style: AppFontStyles.headlineMedium(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            color: AppColors.kWhite),
                                      ),
                                      Spacer(),
                                      IconButton(onPressed: (){
                                        setState(() {
                                          isGalleryShow = false;
                                        });
                                        //Navigator.pop(context);
                                      }, icon: Icon(Icons.close),color: AppColors.kWhite,)
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
                                    // color: Colors.purple,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: GridView.builder(
                                        // controller: scrollController,
                                        padding: EdgeInsets.zero,
                                       // padding: const EdgeInsets.all(8.0),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, // Number of columns
                                          mainAxisSpacing: 15.0, // Vertical spacing
                                          crossAxisSpacing: 20.0, // Horizontal spacing
                                          childAspectRatio: 1
                                        ),
                                        itemCount: serviceData.data!.imageSection!.gallery!.length,
                                        itemBuilder: (context, index) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                          serviceData
                                                              .data!.imageSection!.gallery![index]
                                                              .toString(),
                                                        ))),

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
                ):Wrap()
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
    required int index
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
                selectedIndex == index? AppColors.kRed:AppColors.kWhite,
                selectedIndex == index? AppColors.kRed1:AppColors.kWhite,
              ], // Define your gradient colors here
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(iconPath, width: 50, height: 50)),
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
                    color:  selectedIndex == index?AppColors.kWhite:AppColors.kBlack,
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


  void showGalleryModal(BuildContext context, ServiceDetailsModel serviceModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make background transparent
      builder: (context) {
        return Stack(
          children: [
            // Blurred Background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
              ),
            ),
            // Gallery Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 90,),
                        Text(
                          textAlign: TextAlign.center,
                          'The Shine Gallery/videos',
                          style: AppFontStyles.headlineMedium(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AppColors.kWhite),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close),color: AppColors.kWhite,)
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColors.kWhite,
                    ),
                    Container(
                      height: 670,
                     // color: Colors.purple,
                      child: GridView.builder(
                       // controller: scrollController,
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns
                          mainAxisSpacing: 8.0, // Vertical spacing
                          crossAxisSpacing: 8.0, // Horizontal spacing
                        ),
                        itemCount: serviceModel.data!.imageSection!.gallery!.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              // height:123,
                              // width: 123,
                              // color: Colors.purple,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        serviceModel
                                            .data!.imageSection!.gallery![index]
                                            .toString(),
                                      ))),

                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _viewAll(ServiceDetailsModel serviceDetails) {
    context.read<ReviewBloc>().add(LoadReviewData()); // Trigger event to fetch reviews

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
              height: 500.0,
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
                          child: Text(
                            'Add Review',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 4,
                              color: AppColors.kBlack,
                            ),
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
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ReviewLoaded) {
                        final reviews = state.reviewModel; // List of reviews from the state
                        return Expanded(
                          child: ListView.builder(
                            itemCount: reviews.data!.reviews!.length,
                            itemBuilder: (context, index) {
                              final review = reviews.data!.reviews![index];
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
                                        child: Image.asset(review.profileImage.toString()),
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
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w400,fontSize: 16),
                                              ),
                                              SizedBox(width: 200,),
                                              Text(
                                                review.timestamp.toString(),
                                                style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.kLightGrey),
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
