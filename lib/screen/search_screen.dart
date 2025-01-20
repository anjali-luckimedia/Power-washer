import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/blocs/search/search_bloc.dart';
import 'package:power_washer/repositary/api_repositary.dart';
import 'package:power_washer/utils/app_common/common_textformfield.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:provider/provider.dart';

import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../utils/app_colors.dart';
import '../utils/app_common/Bottom_navigation.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc = SearchBloc(ApiService());
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            CommonTextFormField(
              errorTextColor: AppColors.kBlack,
              controller: searchController,
              hintText: AppString.search,
              borderColor: true,
              prefixIcon: GestureDetector(onTap:(){
                Navigator.pop(context);
              },child: Icon(Icons.arrow_back, color: AppColors.kBlack,size: 25,)),

              onChanged: (query) {
                query = searchController.text;
                searchBloc.add(SearchQueryChanged(query));
              },
              suffixIcon: GestureDetector(
                onTap: (){
                  searchController.clear();
                },
                child: Image.asset(
                  AppImages.cancel,
                  scale: 4.0,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                bloc: searchBloc,
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.searchModel.data!.length,
                      itemBuilder: (context, index) {
                        final item = state.searchModel.data![index];
                        return ListTile(
                          title: Text(item.name.toString()), // Adjust per API response
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.error));
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

  @override
  void dispose() {
    searchBloc.close();
    super.dispose();
  }
}
