import 'package:flutter/material.dart';
import 'package:protected_password/enums/device_screen_type.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceScreenSize: $deviceScreenType \nScreenSize: $screenSize \nLocalWidgetSizw: $localWidgetSize';
  }
}
