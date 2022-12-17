// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { isFromAsset, isFromNetwork }

class CustomSvgView extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? svgColor;

  final ImageType? imageType;
  const CustomSvgView({
    Key? key,
    this.imageUrl,
    this.height,
    this.width,
    this.svgColor = const Color(0xffAD1457),
    this.imageType = ImageType.isFromAsset,
  }) : assert(imageUrl != "" && imageUrl != null);
  @override
  Widget build(BuildContext context) {
    return imageType == ImageType.isFromAsset
        ? SvgPicture.asset(
            imageUrl!,
            height: height ?? 15,
            width: width ?? 15,
            color: svgColor,
          )
        : imageType == ImageType.isFromNetwork
            ? SvgPicture.network(
                imageUrl!,
                height: height ?? 15,
                width: width ?? 15,
                color: svgColor,
                colorBlendMode: BlendMode.color,
              )
            : const SizedBox();
  }
}
