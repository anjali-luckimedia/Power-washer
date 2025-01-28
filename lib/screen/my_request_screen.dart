import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/my_request/my_request_data_bloc.dart';
import 'package:power_washer/blocs/my_request/my_request_data_event.dart';
import 'package:power_washer/blocs/my_request/my_request_data_state.dart';
import 'package:power_washer/screen/notification_screen.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_common_appbar.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_common/app_common_widget.dart';
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
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,

        title: AppString.myRequest,
        onActionTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
        },
        faIcon: FaIcon(
          FontAwesomeIcons.solidBell,
          color: AppColors.kBlack,
          size: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
        child: Column(
          children: [
            /*SizedBox(height: 50,),
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
            ),*/
            Divider(color: AppColors.kLightGrey,thickness: 1,),
            Expanded(
              child: BlocBuilder<MyRequestPageBloc, MyRequestPageState>(
                builder: (context, state) {
                  if (state is MyRequestPageLoading) {
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
                  } else if (state is MyRequestPageLoaded) {
                    return state.myRequestModel.data!.isEmpty?CommonWidget().commonNoData(context):ListView.builder(
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
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: AppColors.kRed)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  //  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.image!,
                                    height: 95,
                                    width: 124,
                                    fit: BoxFit.cover,
                                      errorBuilder: (context, url, error) =>Image.asset('assets/images/mostBookesImage.png',height: 85,
                                        width: 124,
                                        fit: BoxFit.cover,)
                                  ),
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
      case 'Approved':
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
      case 'Approved':
        return AppColors.kWhite; // Green for approved
      case 'Pending':
        return AppColors.kBlack; // Orange for pending
      case 'Rejected':
        return AppColors.kWhite; // Red for rejected
      default:
        return AppColors.kWhite; // Default color for unknown status
    }
  }
}
