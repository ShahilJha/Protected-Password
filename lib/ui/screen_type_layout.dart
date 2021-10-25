import 'package:flutter/material.dart';
import 'package:protected_password/enums/device_screen_type.dart';
import 'package:protected_password/ui/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  const ScreenTypeLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          return tablet ?? mobile;
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          return desktop ?? tablet ?? mobile;
        }

        return mobile;
      },
    );
  }
}
