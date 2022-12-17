import 'package:flutter/material.dart';

class AssetImageCustomWidget extends StatelessWidget {
  final String? assetImageUrl;
  final double? height;
  final double? width;
  const AssetImageCustomWidget({Key? key, this.assetImageUrl, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(
        assetImageUrl!,
      ),
      fit: BoxFit.cover,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
