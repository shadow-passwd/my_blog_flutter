import 'package:flutter/material.dart';

import '../providers/dark_theme_provider.dart';
import '../utils/sizing_information.dart';

Widget myFab(DarkThemeProvider themeChange, BuildContext context,
    Function themeSwitcher, SizingInformation sizingInformation) {
  return (sizingInformation.deviceType == DeviceScreenType.Tablet) ||
          (sizingInformation.deviceType == DeviceScreenType.Mobile)
      ? FloatingActionButton(
          child: Icon(
              themeChange.darkTheme ? Icons.brightness_3 : Icons.brightness_5),
          onPressed: () {
            themeSwitcher(themeChange);
          })
      : null;
}
