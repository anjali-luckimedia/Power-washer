import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_washer/model/service_details_model.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';

import '../../blocs/add_review/add_review_bloc.dart';
import '../../blocs/add_review/add_review_event.dart';
import '../../blocs/add_review/add_review_state.dart';

class AddReviewDialog extends StatefulWidget {
   ServiceDetailsModel? serviceDetailsModel;
   AddReviewDialog({Key? key,this.serviceDetailsModel}) : super(key: key);

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  Set<int> selectedIndex = {}; // Set to store multiple selected indices

  List<String> serviceList =['Mobile Car','Residential','Commercial'];
  List<String> serviceListImage =['assets/images/carWashing.png','assets/images/carWashing.png','assets/images/carWashing.png'];
  TextEditingController reviewController = TextEditingController();
  final ValueNotifier<bool> isAddReviewLoader = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AddReviewBloc, AddReviewState>(
      listener: (context, state) {
        if (state is AddReviewLoading) {
          isAddReviewLoader.value = true; // Update the ValueNotifier
          // Show a loading indicator
          // showDialog(
          //   context: context,
          //   builder: (_) => Center(child: CircularProgressIndicator()),
          //   barrierDismissible: false,
          // );
        } else if (state is AddReviewSuccess) {
          isAddReviewLoader.value = false; // Update the ValueNotifier
          showDialog(
            context: context,
            barrierDismissible: false,
            // Prevents closing on tap outside the dialog
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
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            icon: Icon(Icons.close,color: AppColors.kBlack,),
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
                      Text('Your reviews has been added\n              successfully.', style: AppFontStyles.headlineMedium(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),),
                      SizedBox(height: 16.0),

                    ],
                  ),
                ),
              );
            },
          );
          // Navigator.pop(context); // Close the dialog
          // Navigator.pop(context); // Close the dialog
          // Navigator.pop(context); // Close the dialog
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Review added successfully!')),
          // );
        } else if (state is AddReviewFailure) {
          isAddReviewLoader.value = false; // Update the ValueNotifier
          Navigator.pop(context); // Close the loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Dialog(

          backgroundColor: AppColors.kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
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
                    AppString.addReview,
                    style: AppFontStyles.dinTextStyle(
                      color: AppColors.kBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Divider(color: AppColors.kLightGrey, thickness: 1),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.serviceDetailsModel!.data!.serviceDetails!.name.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      // Profile Picture
                      Center(
                        child:Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
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
                            child: Image.asset('assets/images/dummy.png'),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Subtitle
                      Center(
                        child: Text(
                          "How was your experience with\n                     service?",
                          style: AppFontStyles.headlineMedium(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Rating Bar
                      Center(
                        child: RatingBar(
                          alignment: Alignment.center,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          onRatingChanged: (value) => debugPrint('$value'),
                          initialRating: 3,
                          maxRating: 5,
                          halfFilledColor: AppColors.kYellow,
                          isHalfAllowed: true,
                          halfFilledIcon:Icons.star ,
                          filledColor: AppColors.kYellow,

                        ),
                      ),

                      const SizedBox(height: 15),

                      // Services Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          "Services",
                          style: AppFontStyles.headlineMedium(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 80, // Adjust the height of the row as needed

                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount:  widget.serviceDetailsModel!.data!.services!.length,
                          itemBuilder: (context, index) {
                            final service =  widget.serviceDetailsModel!.data!.services![index];
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  String categoryId =  service.categoryId.toString(); // Get the categoryId

                                  if (selectedIndex.contains(categoryId)) {
                                    selectedIndex.remove(categoryId); // Deselect
                                  } else {
                                    selectedIndex.add(int.parse(categoryId)); // Select
                                  }


                                });
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(serviceName:service.name! ,),));
                              },
                              child: _buildPressureWashCard(
                                  iconPath: service.image.toString(),
                                  title: service.name.toString(),
                                  index: index,
                                  isSelected: selectedIndex.contains(int.parse(service.categoryId.toString()))
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Write Review Section
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0, top: 5),
                            child: GestureDetector(
                              child: SvgPicture.asset(AppImages.editImage),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Write your review",
                            style: AppFontStyles.headlineMedium(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: TextFormField(
                            maxLines: 5,
                            style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                            controller: reviewController,

                            decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:AppColors.kLightGrey, width: 1),
                                //borderSide: BorderSide.none
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:AppColors.kLightGrey, width: 1),
                                // borderSide: BorderSide.none
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:AppColors.kLightGrey, width: 1),
                                //borderSide: BorderSide.none
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.kYellow, width: 1),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                              hintStyle: AppFontStyles.headlineMedium(
                                  fontSize: 16,
                                  color: AppColors.kLightGrey,
                                  fontWeight: FontWeight.w400
                              ),

                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
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
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isAddReviewLoader,
                            builder: (context, isLoading, child) {
                              return ElevatedButton(
                                onPressed: isLoading
                                    ? null // Disable the button while loading
                                    : () {
                                  final serviceId = widget.serviceDetailsModel
                                          ?.data!.serviceDetails!.id
                                          .toString() ??
                                      '';
                                  final categories = selectedIndex;
                                  final ratings =
                                      '3'; // Use the value from your `RatingBar`
                                  final message = reviewController.text;

                                  if (serviceId.isEmpty ||
                                      message.isEmpty ||
                                      categories.isEmpty) {
                                    // Show an error if required fields are empty
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please fill in all required fields.')),
                                    );
                                    return;
                                  }

                                  // Dispatch the AddReviewButtonPressed event
                                  context.read<AddReviewBloc>().add(
                                        AddReviewButtonPressed(
                                          serviceId: serviceId,
                                          categories: categories,
                                          ratings: ratings,
                                          message: message,
                                        ),
                                      );
                                  // Action for booking
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  // Set transparent as the background
                                  shadowColor: Colors.transparent,
                                  // Remove default button shadow
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60.0, vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Match border radius
                                  ),
                                ),
                                child: isLoading
                                    ? CircularProgressIndicator(
                                    color: AppColors.kWhite)
                                    :Text(
                                  AppString.submit.toUpperCase(),
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
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.network(iconPath, width: 30, height: 30)),
              SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                title,
                style: AppFontStyles.headlineMedium(
                  fontWeight: FontWeight.w800,
                  fontSize: 8,
                  color:  isSelected?AppColors.kWhite:AppColors.kBlack,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

}