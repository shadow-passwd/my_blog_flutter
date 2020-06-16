import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';

import '../routes.dart';
import '../providers/dark_theme_provider.dart';
import 'base_widget.dart';
import 'topbar_widget.dart';
import 'fab.dart';
import 'drawer.dart';
import 'theme_switcher.dart';
import 'navbar_widget.dart';
import '../utils/sizing_information.dart';
import '../model/user_login.dart';
import 'display_page_widget.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with SingleTickerProviderStateMixin {
  String currentRouteName = Routes.home;
  double buttonSize = 30;
  AnimationController animationController;

  Animation<double> animation;
  bool cirAn = false;

  bool isDrawerOpened = false;

  void callback(String route, Size boxSize, BuildContext drawerContext,
      bool isDrawerOpened) {
    setState(() {
      currentRouteName = route;
      buttonSize = 40;
      if (isDrawerOpened) Navigator.of(drawerContext).pop();

      // buttonSize = constraints.maxWidth * 0.8;
    });
  }

  void themeSwitcher(DarkThemeProvider themeChange) {
    setState(() {
      cirAn = true;
    });
    themeChange.darkTheme = !themeChange.darkTheme;
    if (animationController.status == AnimationStatus.forward ||
        animationController.status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    } else {
      animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    currentRouteName = Routes.home;
    setState(() {
      buttonSize = 40;
      // buttonSize = MediaQuery.of(context).size.width * 0.8;
    });
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
      // reverseCurve: Curves.easeInOut
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var size = MediaQuery.of(context).size;

    return cirAn
        ? CircularRevealAnimation(
            centerOffset: Offset(size.height / 15, size.width / 3.5),
            animation: animation,
            child: buildBody(context, themeChange),
          )
        : buildBody(context, themeChange);
  }

  SafeArea buildBody(BuildContext context, DarkThemeProvider themeChange) {
    return SafeArea(
      child: BaseWidget(
        builder: (context, sizingInformation) {
          return Scaffold(
            floatingActionButton:
                myFab(themeChange, context, themeSwitcher, sizingInformation),
            appBar: (sizingInformation.deviceType == DeviceScreenType.Tablet) ||
                    (sizingInformation.deviceType == DeviceScreenType.Mobile)
                ? AppBar()
                : null,
            drawer: myDrawer(sizingInformation.localWidgetSize, callback,
                User.isLogin, isDrawerOpened, context, sizingInformation),
            body: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopBar(
                          boxSize: sizingInformation.screenSize,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (sizingInformation.deviceType !=
                                        DeviceScreenType.Tablet) &&
                                    (sizingInformation.deviceType !=
                                        DeviceScreenType.Mobile)
                                ? NavBar(
                                    sizingInformation.screenSize,
                                    callback,
                                    User.isLogin,
                                    size: buttonSize,
                                    currentRouteName: currentRouteName,
                                  )
                                : SizedBox(),
                            displayPage(
                                currentRouteName, context, sizingInformation),
                          ],
                        ),
                      ],
                    ),
                  ),
                  BuildAnimationBulb(
                      sizingInformation, themeChange, themeSwitcher)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
