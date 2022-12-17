import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gif_world/controller/home/home_screen_controller.dart';
import 'package:gif_world/controller/search/search_controller.dart';
import 'package:gif_world/src/widgets/ads_widget/banner_ad_widget.dart';
import 'package:gif_world/src/widgets/circular_progress_indicator_widget.dart';
import 'package:gif_world/src/widgets/home/list_image_view.dart';
import 'package:gif_world/src/widgets/no_data_widget.dart';
import 'package:gif_world/src/widgets/no_internet_widget.dart';
import 'package:gif_world/utilities/arguments/arguments_utilities.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/routes/route_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController? _searchScrollController;
  final SearchScreenController _searchScreenController =
      Get.find(tag: SearchScreenController().toString());

  @override
  void initState() {
    super.initState();

    _searchScrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
          ..addListener(() async {
            if (_searchScrollController!.offset >=
                    _searchScrollController!.position.maxScrollExtent &&
                !_searchScrollController!.position.outOfRange) {
              _searchScreenController.searchGif(
                  context: context,
                  searchKeyword:
                      _searchScreenController.searchEditingController.text);
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.10,
        title: const Text('''GIF's World'''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.toNamed(RouteUtilities.homeScreen);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GetBuilder<SearchScreenController>(
                init: _searchScreenController,
                builder: (_) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: VariableUtilities.theme.whiteColor,
                    ),
                    height: screenSize.height * 0.06,
                    width: screenSize.width * 0.96,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                          ),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 4),
                            child: TextFormField(
                              controller: _searchScreenController
                                  .searchEditingController,
                              cursorWidth: 2,
                              cursorColor: VariableUtilities.theme.primaryColor,
                              onChanged: (String value) {
                                _searchScreenController
                                    .searchGifListClearUpdate();
                                if (_searchScreenController
                                    .searchEditingController.text.isEmpty) {
                                  _searchScreenController
                                      .searchGifListClearUpdate();
                                } else {
                                  debugPrint(value);

                                  _searchScreenController.searchGif(
                                      context: context,
                                      searchKeyword: _searchScreenController
                                          .searchEditingController.text);
                                }
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
      body: GetBuilder<SearchScreenController>(
          init: _searchScreenController,
          builder: (_) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _searchScreenController.searchGifList.isNotEmpty
                    ? StaggeredGridView.countBuilder(
                        controller: _searchScrollController,
                        crossAxisSpacing: 0.5,
                        mainAxisSpacing: 0.5,
                        itemCount: _searchScreenController.searchGifList.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteUtilities.imageViewScreen,
                                  arguments: DetailsScreenArguments(
                                      imageUrl: _searchScreenController
                                          .searchGifList[index]['gif']!.url));
                            },
                            child: ListImageViewWidget(
                              gifUrl: _searchScreenController
                                  .searchGifList[index]['gif']!.url!,
                              isLableShow: false,
                              lable: '',
                            ),
                          );
                        },
                        crossAxisCount: 2,
                        staggeredTileBuilder: (int index) {
                          // if (_searchScreenController.searchGifList[index]
                          //     is ImageClass) {
                          //   return const StaggeredTile.count(2, 1);
                          // } else {
                          //   return const StaggeredTile.count(1, 1);
                          // }
                          return const StaggeredTile.count(1, 1);
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            'Search GIF by Category to get interesting GIFs.',
                            textAlign: TextAlign.center,
                            style: FontUtilities.h18(
                              fontColor: VariableUtilities.theme.primaryColor,
                              fontWeight: FWT.bold,
                            ),
                          ),
                        ),
                      ),
                Visibility(
                  visible: _searchScreenController.searchDynamicList.isEmpty
                      ? _searchScreenController
                          .isSearchCircularProgressIndicator
                      : false,
                  child: const Center(
                    child: CircularProgressIndicatorWidget(),
                  ),
                ),
                Visibility(
                  visible: _searchScreenController.isSearchNoDataWidget,
                  child: const Center(
                    child: NoDataWidget(),
                  ),
                ),
                Visibility(
                  visible: _searchScreenController.isNoInternetWidget,
                  child: const Center(
                    child: NoInternetWidget(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: BannerAdWidget(
                    adSize: AdSize.largeBanner,
                    key: UniqueKey(),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
