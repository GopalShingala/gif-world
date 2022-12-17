import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';

class ListImageViewWidget extends StatelessWidget {
  final String? gifUrl;
  final String? lable;
  final bool? isLableShow;
  const ListImageViewWidget({Key? key, this.gifUrl, this.lable, this.isLableShow = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: gifUrl!,
                errorWidget: (context, url, widget) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, child) => const CupertinoActivityIndicator(),
                fit: BoxFit.cover,
              ),
            ],
          ),
          isLableShow == true
              ? Container(
                  height: screenSize.height * 0.04,
                  width: screenSize.width * 0.48,
                  color: VariableUtilities.theme.whiteColor.withOpacity(0.9),
                  child: Center(
                    child: Text(
                      lable!,
                      style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.primaryColor,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
