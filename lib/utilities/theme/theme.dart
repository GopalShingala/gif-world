library application_theme;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gif_world/utilities/settings/preference_key.dart';
import 'package:gif_world/utilities/settings/variable_utilities.dart';

import 'theme_data/dark_theme_data.dart';
part 'theme_data/light_theme_data.dart';
part 'theme_handler.dart';

class ThemeManager {
  static initializeTheme() {
    String storedTheme = VariableUtilities.prefs.read<String>(PreferenceKey.storedTheme) ?? "auto";
    switch (storedTheme) {
      case "dark":
        VariableUtilities.theme = DarkThemeData();
        break;
      case "light":
        VariableUtilities.theme = LightThemeData();
        break;
      default:
        // bool isSystemModeIsLight = true;
        //  (SchedulerBinding.instance.window.platformBrightness ?? Brightness.light) == Brightness.light;
        // if (isSystemModeIsLight) {
        VariableUtilities.theme = LightThemeData();
      // } else {
      //   VariableUtilities.theme = DarkThemeData();
      // }
    }
  }

  swichTheme(String theme) {
    switch (theme) {
      case "light":
        VariableUtilities.theme = LightThemeData();
        break;
      case "dark":
        VariableUtilities.theme = DarkThemeData();
        break;
      default:
        VariableUtilities.theme = LightThemeData();
    }
  }
}
