import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/my_request/my_request_data_bloc.dart';
import 'package:power_washer/blocs/my_request/my_request_data_event.dart';
import 'package:power_washer/blocs/my_request/my_request_data_state.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_string.dart';

import '../utils/app_images.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<MyRequestPageBloc>().add(LoadMyRequestPageData());
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 50,),
                // GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Icon(
                //       Icons.arrow_back,
                //       color: AppColors.kBlack,
                //       size: 25,
                //     )),
               Text(AppString.myRequest.toUpperCase(),style: AppFontStyles.headlineMedium(fontWeight: FontWeight.w800,fontSize: 18,color: AppColors.kBlack,)),
                GestureDetector(
                    onTap: () {
                  //    _modalBottomSheetMenu();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: AppColors.kBlack,
                      size: 25,
                    )),
              ],
            ),
            Divider(color: AppColors.kLightGrey,thickness: 1,),
            Expanded(
              child: BlocBuilder<MyRequestPageBloc, MyRequestPageState>(
                builder: (context, state) {
                  if (state is MyRequestPageLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MyRequestPageLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.myRequestModel.data!.length,
                      itemBuilder: (context, index) {
                        final item = state.myRequestModel.data![index];
                        final status = state.myRequestModel.data![index].status;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Section
                              ClipRRect(
                                //  borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.image!,
                                  height: 83,
                                  width: 124,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              // Details Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    Row(
                                      children: [
                                      SvgPicture.asset(AppImages.calender,height: 15,),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            item.date.toString(),
                                            style: AppFontStyles.headlineMedium(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.kBlack
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                        SvgPicture.asset(AppImages.category,height: 15,),
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

                                  ],
                                ),
                              ),
                              // Distance Section
                              Column(
                                children: [
                                  Container(
                                    height: 13,
                                    width: 46,
                                   // padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                     color:_getStatusColor(status!) ,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.status.toString(),
                                        style: AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: _getTextColor(status!)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                        // return ListTile(
                        //   title: Text(item.name.toString()), // Adjust per API response
                        // );
                      },
                    );
                  } else if (state is MyRequestPageError) {
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
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approve':
        return AppColors.kGreen; // Green for approved
      case 'Pending':
        return AppColors.kYellow; // Orange for pending
      case 'Rejected':
        return AppColors.kRed; // Red for rejected
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
  Color _getTextColor(String status) {
    switch (status) {
      case 'Approve':
        return AppColors.kWhite; // Green for approved
      case 'Pending':
        return AppColors.kBlack; // Orange for pending
      case 'Rejected':
        return AppColors.kWhite; // Red for rejected
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
}
