import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/search/search_bloc.dart';
import 'package:power_washer/blocs/search/search_event.dart';
import 'package:power_washer/blocs/search/search_state.dart';
import 'package:power_washer/screen/service_details_screen.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/bottom_navigation.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_common/app_font_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc; // Declare the SearchBloc
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc = SearchBloc(); // Initialize the Bloc
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => searchBloc,
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        bottomNavigationBar: BottomNavigation(currentIndex: 0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CommonTextFormField(
                maxLines: 1,
                errorTextColor: AppColors.kBlack,
                controller: searchController,
                hintText: AppString.search,
                borderColor: true,
                prefixIcon: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.kBlack,
                    size: 25,
                  ),
                ),
                onChanged: (query) {
                  print(searchController.text);
                   query = searchController.text;
                   searchBloc.add(LoadSearchData(query, '', ''));
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    searchController.clear();
                    searchBloc.add(LoadSearchData('', '', 'rating'));
                  },
                  child: searchController.text.isNotEmpty?Image.asset(
                    AppImages.cancel,
                    scale: 4.0,
                  ): SizedBox.shrink(),
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return  Center(child: Text('Enter a search text', style: AppFontStyles.headlineMedium(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kBlack
                      ),));
                    } else if (state is SearchLoading) {
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
                    } else if (state is SearchLoaded) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.searchModel.data!.length,
                        itemBuilder: (context, index) {
                          final item = state.searchModel.data![index];
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

                        },
                      );
                    } else if (state is SearchError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchBloc.close();
    super.dispose();
  }
}
