import 'package:flutter/material.dart';

import '../utils/sizing_information.dart';
import 'navbar_widget.dart';

Widget myDrawer(
    Size boxSize,
    Function callback,
    bool isLogin,
    bool isDrawerOpened,
    BuildContext context,
    SizingInformation sizingInformation) {
  return (sizingInformation.deviceType == DeviceScreenType.Tablet) ||
          (sizingInformation.deviceType == DeviceScreenType.Mobile)
      ? Drawer(
          child: NavBar(
            boxSize,
            callback,
            isLogin,
            isDrawerOpened: true,
            drawerContext: context,
          ),
        )
      : null;
}
