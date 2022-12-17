import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gif_world/controller/home/home_screen_controller.dart';
import 'package:gif_world/controller/search/search_controller.dart';
import 'package:gif_world/src/widgets/ads_widget/banner_ad_widget.dart';
import 'package:gif_world/src/widgets/circular_progress_indicator_widget.dart';
import 'package:gif_world/src/widgets/home/list_image_view.dart';
import 'package:gif_world/src/widgets/no_data_widget.dart';
import 'package:gif_world/src/widgets/no_internet_widget.dart';
import 'package:gif_world/src/widgets/popup_menu_widget.dart';
import 'package:gif_world/utilities/arguments/arguments_utilities.dart';
import 'package:gif_world/utilities/routes/route_utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ImageListScreen extends StatefulWidget {
  final ImageListScreenArguments? arguments;
  const ImageListScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  final SearchScreenController _searchScreenController =
      Get.find(tag: SearchScreenController().toString());
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint(widget.arguments!.categoryName);
      _searchScreenController.searchGifListClearUpdate;
      _searchScreenController.searchGif(
          context: context, searchKeyword: widget.arguments!.categoryName);
    });

    _scrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
          ..addListener(() {
            if (_scrollController!.offset >=
                    _scrollController!.position.maxScrollExtent &&
                !_scrollController!.position.outOfRange) {
              _searchScreenController.searchGif(
                  context: context,
                  searchKeyword: widget.arguments!.categoryName);
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments!.categoryName!),
        actions: const [
          PopUpMenuWidget(),
        ],
      ),
      body: GetBuilder<SearchScreenController>(
          init: _searchScreenController,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _searchScreenController.searchGifList.isNotEmpty
                      ? StaggeredGridView.countBuilder(
                          controller: _scrollController,
                          crossAxisSpacing: 0.5,
                          mainAxisSpacing: 0.5,
                          itemCount:
                              _searchScreenController.searchGifList.length,
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
                            return const StaggeredTile.count(1, 1);
                          },
                        )
                      : Visibility(
                          visible: _searchScreenController
                              .isSearchCircularProgressIndicator,
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
                    child: BannerAdWidget(
                      adSize: AdSize.largeBanner,
                      key: UniqueKey(),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
