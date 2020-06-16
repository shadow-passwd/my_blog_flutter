import 'package:flutter/material.dart';

import '../utils/sizing_information.dart';
import '../providers/dark_theme_provider.dart';

import '../constants/images_location.dart';

class BuildAnimationBulb extends StatelessWidget {
  final SizingInformation sizingInformation;
  final DarkThemeProvider themeChange;

  final Function themeSwitcher;

  BuildAnimationBulb(
      this.sizingInformation, this.themeChange, this.themeSwitcher);

  @override
  Widget build(BuildContext context) {
    return (sizingInformation.deviceType != DeviceScreenType.Tablet) &&
            (sizingInformation.deviceType != DeviceScreenType.Mobile)
        ? Container(
            alignment: Alignment.topRight,
            width: sizingInformation.screenSize.width * 0.05,
            child: InkWell(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              onTap: () {
                themeSwitcher(themeChange);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: sizingInformation.screenSize.height / 5.4,
                width: sizingInformation.screenSize.width * 0.05 > 50
                    ? 50
                    : sizingInformation.screenSize.width * 0.05,
                child: Image.asset(themeChange.darkTheme
                    ? ImageLocation.bulb_off
                    : ImageLocation.bulb_on),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).hoverColor,
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
