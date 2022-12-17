part of application_theme;

abstract class ThemeHandler {
  final Color primaryColor;
  final Color whiteColor;
  final Color blackColor;

  ThemeHandler({
    required this.primaryColor,
    required this.whiteColor,
    required this.blackColor,
  });
}
