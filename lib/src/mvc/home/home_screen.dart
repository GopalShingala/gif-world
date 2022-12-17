// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gif_world/controller/home/home_screen_controller.dart';
import 'package:gif_world/src/widgets/ads_widget/banner_ad_widget.dart';
import 'package:gif_world/src/widgets/ads_widget/native_ad-widget.dart';
import 'package:gif_world/src/widgets/asset_image_widget.dart';
import 'package:gif_world/src/widgets/circular_progress_indicator_widget.dart';
import 'package:gif_world/src/widgets/home/drawer_fields_widget.dart';
import 'package:gif_world/src/widgets/home/list_image_view.dart';
import 'package:gif_world/src/widgets/home/tabbar_title_widget.dart';
import 'package:gif_world/src/widgets/no_data_widget.dart';
import 'package:gif_world/src/widgets/no_internet_widget.dart';
import 'package:gif_world/src/widgets/popup_menu_widget.dart';
import 'package:gif_world/utilities/arguments/arguments_utilities.dart';
import 'package:gif_world/utilities/assets/asset_utilities.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/routes/route_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeScreenController _homeScreenController =
      Get.find(tag: HomeScreenController().toString());
  TabController? _tabController;
  ScrollController? _trendingScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _homeScreenController.trendingGif(context: context);
    });
    _trendingScrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
          ..addListener(() async {
            if (_trendingScrollController!.offset >=
                    _trendingScrollController!.position.maxScrollExtent &&
                !_trendingScrollController!.position.outOfRange) {
              _homeScreenController.trendingGif(context: context);
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('''GIF's World'''),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(RouteUtilities.searchScreen);
              },
              icon: const Icon(Icons.search),
            ),
            PopUpMenuWidget(),
          ],
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor:
                VariableUtilities.theme.whiteColor.withOpacity(0.5),
            tabs: const [
              TabBarTitleWidget(
                lable: 'Trending',
              ),
              TabBarTitleWidget(
                lable: 'Featured',
              ),
              TabBarTitleWidget(
                lable: 'Explore',
              ),
            ],
            onTap: (int value) async {
              debugPrint('PAGE INDEX ----->>> $value');
              if (value == 0) {
                if (_homeScreenController.trendingGifList.isEmpty) {
                  await _homeScreenController.trendingGif(context: context);
                }
              } else if (value == 1) {
                if (_homeScreenController.featuredTagList.isEmpty) {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) =>
                      _homeScreenController.featuredGif(context: context));
                }
              } else {
                if (_homeScreenController.exploreTagList.isEmpty) {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) =>
                      _homeScreenController.exploreGif(context: context));
                }
              }
            },
          ),
        ),
        body: GetBuilder<HomeScreenController>(
            init: _homeScreenController,
            builder: (_) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.start,
                      children: [
                        Stack(
                          children: [
                            _homeScreenController.trendingGifList.isNotEmpty
                                ? StaggeredGridView.countBuilder(
                                    controller: _trendingScrollController,
                                    crossAxisSpacing: 0.5,
                                    mainAxisSpacing: 0.5,
                                    itemCount: _homeScreenController
                                        .trendingGifList.length,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteUtilities.imageViewScreen,
                                              arguments: DetailsScreenArguments(
                                                  imageUrl:
                                                      _homeScreenController
                                                          .trendingGifList[
                                                              index]['gif']!
                                                          .url));
                                        },
                                        child: ListImageViewWidget(
                                          gifUrl: _homeScreenController
                                              .trendingGifList[index]['gif']!
                                              .url!,
                                          isLableShow: false,
                                          lable: '',
                                        ),
                                      );
                                    },
                                    crossAxisCount: 2,
                                    staggeredTileBuilder: (int index) {
                                      // if (_homeScreenController
                                      //         .trendingDynamicList[index]
                                      //     is ImageClass) {
                                      //   return StaggeredTile.count(2, 1);
                                      // } else {
                                      //   return StaggeredTile.count(1, 1);
                                      // }
                                      return StaggeredTile.count(1, 1);
                                    },
                                  )
                                : Visibility(
                                    visible: _homeScreenController
                                        .isTrendingCircularProgressIndicator,
                                    child: Center(
                                      child: CircularProgressIndicatorWidget(),
                                    ),
                                  ),
                            Visibility(
                              visible:
                                  _homeScreenController.isTrendingNodataWidget,
                              child: Center(
                                child: NoDataWidget(),
                              ),
                            ),
                            Visibility(
                              visible: _homeScreenController.isNoInternetWidget,
                              child: Center(
                                child: NoInternetWidget(),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _homeScreenController.featuredTagList.isNotEmpty
                                ? StaggeredGridView.countBuilder(
                                    controller: _trendingScrollController,
                                    crossAxisSpacing: 0.5,
                                    mainAxisSpacing: 0.5,
                                    itemCount: _homeScreenController
                                        .featuredTagList.length,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteUtilities.imageListScreen,
                                              arguments:
                                                  ImageListScreenArguments(
                                                categoryName:
                                                    _homeScreenController
                                                        .featuredTagList[index]
                                                        .searchItem,
                                              ));
                                        },
                                        child: ListImageViewWidget(
                                          gifUrl: _homeScreenController
                                              .featuredTagList[index].image,
                                          isLableShow: true,
                                          lable: _homeScreenController
                                              .featuredTagList[index].name,
                                        ),
                                      );
                                    },
                                    crossAxisCount: 2,
                                    staggeredTileBuilder: (int index) {
                                      // if (_homeScreenController
                                      //         .featuredDynamicList[index]
                                      //         .image ==
                                      //     null) {
                                      //   return StaggeredTile.count(2, 1);
                                      // } else {
                                      //   return StaggeredTile.count(1, 1);
                                      // }
                                      return StaggeredTile.count(1, 1);
                                    },
                                  )
                                : Visibility(
                                    visible: _homeScreenController
                                        .isFeaturedCircularProgressIndicator,
                                    child: Center(
                                      child: CircularProgressIndicatorWidget(),
                                    ),
                                  ),
                            Visibility(
                              visible:
                                  _homeScreenController.isFeaturedNodataWidget,
                              child: Center(
                                child: NoDataWidget(),
                              ),
                            ),
                            Visibility(
                              visible: _homeScreenController.isNoInternetWidget,
                              child: Center(
                                child: NoInternetWidget(),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            _homeScreenController.exploreTagList.isNotEmpty
                                ? StaggeredGridView.countBuilder(
                                    controller: _trendingScrollController,
                                    crossAxisSpacing: 0.5,
                                    mainAxisSpacing: 0.5,
                                    itemCount: _homeScreenController
                                        .exploreTagList.length,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteUtilities.imageListScreen,
                                              arguments:
                                                  ImageListScreenArguments(
                                                categoryName:
                                                    _homeScreenController
                                                        .exploreTagList[index]
                                                        .searchterm,
                                              ));
                                        },
                                        child: ListImageViewWidget(
                                          gifUrl: _homeScreenController
                                              .exploreTagList[index].image,
                                          isLableShow: true,
                                          lable: _homeScreenController
                                              .exploreTagList[index].name,
                                        ),
                                      );
                                    },
                                    crossAxisCount: 2,
                                    staggeredTileBuilder: (int index) {
                                      return StaggeredTile.count(1, 1);
                                    },
                                  )
                                : Visibility(
                                    visible: _homeScreenController
                                        .isExploreCircularProgressIndicator,
                                    child: Center(
                                      child: CircularProgressIndicatorWidget(),
                                    ),
                                  ),
                            Visibility(
                              visible:
                                  _homeScreenController.isExploreNoDataWidget,
                              child: Center(
                                child: NoDataWidget(),
                              ),
                            ),
                            Visibility(
                              visible: _homeScreenController.isNoInternetWidget,
                              child: Center(
                                child: NoInternetWidget(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: BannerAdWidget(
                      adSize: AdSize.fullBanner,
                      key: UniqueKey(),
                    ),
                  ),
                ],
              );
            }),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: screenSize.height * 0.30,
                width: double.infinity,
                color: VariableUtilities.theme.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AssetImageCustomWidget(
                      assetImageUrl: AssetUtilities.logoRecImagePng,
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      '''GIF's World''',
                      style: FontUtilities.h24(
                          fontColor: VariableUtilities.theme.whiteColor,
                          fontWeight: FWT.semiBold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.sonImageSvg,
                        lableName: 'Good Morning',
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Good Morning',
                            ),
                          );
                        },
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.nightImageSvg,
                        lableName: 'Good Night',
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Good NIGHT',
                            ),
                          );
                        },
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.cakeImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Happy Birthday',
                            ),
                          );
                        },
                        lableName: 'Happy Birthday',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.congratulationImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Congratulation',
                            ),
                          );
                        },
                        lableName: 'Congratulation',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.loveImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Love',
                            ),
                          );
                        },
                        lableName: 'Love',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.romanticImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Romantic',
                            ),
                          );
                        },
                        lableName: 'Romantic',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.happyImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Happy',
                            ),
                          );
                        },
                        lableName: 'Happy',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.sadImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Sad',
                            ),
                          );
                        },
                        lableName: 'Sad',
                      ),
                      DrawerFieldsWidget(
                        imageUrl: AssetUtilities.funnyImageSvg,
                        onTap: () {
                          Get.toNamed(
                            RouteUtilities.imageListScreen,
                            arguments: ImageListScreenArguments(
                              categoryName: 'Funny',
                            ),
                          );
                        },
                        lableName: 'Funny',
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
