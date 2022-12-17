import 'package:flutter/material.dart';

/// FontUtilities is main base class for all the styles of fonts used in the whole application.
/// you can directly change the font styles in this file.
/// so, all the fonts used in application will be changed.
/// there we provided some of the most used fontsizes.
/// you can add new fontsize if you don't find in this file.
class FontUtilities {
  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle h10({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: 10,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 18
  static TextStyle h18({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 20
  static TextStyle h20({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: 20,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 22
  static TextStyle h22({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: 22,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 24
  static TextStyle h24({
    required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: 24,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
    );
  }
}

/// these are the most commonly used font weight for every mobile application and websites.
enum FWT {
  bold, //700
  semiBold, // 600
  medium, // 500
  regular, //400
  light, // 200
}

/// THIS FUNCTION IS USED TO SET FONT WEIGHT ACCORDING TO SELECTED ENUM...
FontWeight getFontWeight(FWT fwt) {
  switch (fwt) {
    case FWT.light:
      return FontWeight.w200;
    case FWT.regular:
      return FontWeight.w400;
    case FWT.medium:
      return FontWeight.w500;
    case FWT.semiBold:
      return FontWeight.w600;
    case FWT.bold:
      return FontWeight.w700;
  }
}
