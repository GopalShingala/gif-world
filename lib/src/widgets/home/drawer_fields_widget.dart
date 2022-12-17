import 'package:flutter/material.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';

import '../svg_viwer_widget.dart';


class DrawerFieldsWidget extends StatelessWidget {
  final String? imageUrl;
  final String? lableName;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  const DrawerFieldsWidget({Key? key, this.imageUrl, this.lableName, this.height, this.width, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvgView(
              imageUrl: imageUrl,
              svgColor: VariableUtilities.theme.primaryColor,
              height: 25,
              width: 25,
              
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              lableName!,
              style: FontUtilities.h20(fontColor: VariableUtilities.theme.primaryColor, fontWeight: FWT.medium),
            ),
          ],
        ),
      ),
    );
  }
}
