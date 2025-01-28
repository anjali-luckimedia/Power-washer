
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/notification/notification_bloc.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/app_common_appbar.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:provider/provider.dart';

import '../blocs/notification/notification_event.dart';
import '../blocs/notification/notification_state.dart';
import '../utils/app_common/Bottom_navigation.dart';
import '../utils/app_string.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<NotificationBLoc>().add(LoadNotificationPageData());

    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,

        title: AppString.notification,
        iconData: Icons.arrow_back,
      ),
      body: BlocBuilder<NotificationBLoc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            final notification = state.notificationModel;

            return  SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notification.data!.length,
                    itemBuilder: (context, index) {
                      return SwipeActionCell(
                        backgroundColor: AppColors.kWhite,
                        key: ValueKey(notification.data![index].notificationTitle),
                       // key: ObjectKey(list[index]), /// this key is necessary
                        trailingActions: <SwipeAction>[




                          SwipeAction(
                              //title: "delete",
                              icon: SvgPicture.asset(AppImages.delete,color: AppColors.kWhite,),
                              onTap: (CompletionHandler handler) async {
                             //   list.removeAt(index);
                                setState(() {});
                              },

                              forceAlignmentToBoundary: false,
                              widthSpace: 70,
                              color: AppColors.kRed),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 15,right: 15),
                          child: GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ExcursionsDetailsPage(),));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        notification.data![index].timestamp
                                            .toString(),

                                        style:
                                        AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            color: AppColors.kLightGrey,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [AppColors.kRed, AppColors.kRed],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                        ),
                                        padding: EdgeInsets.all(2),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [AppColors.kWhite, AppColors.kWhite],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                            child: Image.network( notification.data![index].image
                                                .toString(),fit: BoxFit.cover,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded( // Wrap the Column in Expanded
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notification.data![index].notificationTitle.toString(),
                                              style: AppFontStyles.headlineMedium(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,

                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis, // Prevent overflow
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                notification.data![index].notificationText.toString(),
                                                style: AppFontStyles.headlineMedium(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis, // Prevent overflow
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        notification.data![index].time
                                            .toString(),

                                        style:
                                        AppFontStyles.headlineMedium(
                                            fontSize: 10,
                                            color: AppColors.kLightGrey,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: AppColors.kLightGrey,)
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                ],
              ),
            );
          } else if (state is NotificationError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
  void doNothing(BuildContext context) {}

}
