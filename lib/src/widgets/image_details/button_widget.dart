import 'package:flutter/material.dart';
import 'package:gif_world/utilities/fonts/font_utilities.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';

class ButtonWidget extends StatelessWidget {
  final String? lable;
  final VoidCallback? onTap;
  const ButtonWidget({Key? key, this.lable, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: screenSize.height * 0.05,
            width: screenSize.width * 0.44,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  lable!,
                  style: FontUtilities.h18(
                    fontColor: VariableUtilities.theme.primaryColor,
                    fontWeight: FWT.semiBold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
