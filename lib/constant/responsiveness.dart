import 'package:flutter/material.dart';

const int largeScreenSize = 780;
const int smallScreenSize = 360;

class ResponsiveWidget extends StatelessWidget {
  final Widget? largeScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    this.largeScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < largeScreenSize;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= largeScreenSize) {
          return largeScreen!;
        } else {
          return smallScreen!;
        }
      },
    );
  }
}
