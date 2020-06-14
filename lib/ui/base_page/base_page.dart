import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';

import '../../widgets/base_widget.dart';
import '../../utils/sizing_information.dart';

import '../../ui/home/home.dart';
import '../../ui/login/login.dart';
import '../../ui/who_am_i/who_am_i.dart';
import '../../ui/userProfile/user_profile.dart';
import '../../ui/blog/blog_home.dart';
import '../../ui/editor/editor.dart';
import '../../model/user_login.dart';

import '../../constants/images_location.dart';

import '../../providers/dark_theme_provider.dart';

import '../../widgets/navbar_widget.dart';
import '../../widgets/topbar_widget.dart';
import '../../routes.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage>
    with SingleTickerProviderStateMixin {
  String currentRouteName = Routes.home;
  double buttonSize = 30;
  AnimationController animationController;

  Animation<double> animation;
  bool cirAn = false;

  void callback(String route, Size boxSize) {
    setState(() {
      currentRouteName = route;
      buttonSize = 40;
      // buttonSize = constraints.maxWidth * 0.8;
    });
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
            appBar: (sizingInformation.deviceType == DeviceScreenType.Tablet) ||
                    (sizingInformation.deviceType == DeviceScreenType.Mobile)
                ? AppBar()
                : null,
            drawer: (sizingInformation.deviceType == DeviceScreenType.Tablet) ||
                    (sizingInformation.deviceType == DeviceScreenType.Mobile)
                ? myDrawer(
                    sizingInformation.localWidgetSize, callback, User.isLogin)
                : null,
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
                            Center(
                              child: Container(
                                width: sizingInformation.localWidgetSize.width *
                                    0.75,
                                height:
                                    sizingInformation.localWidgetSize.height *
                                        0.7,
                                alignment: Alignment.center,
                                child: SingleChildScrollView(
                                  child: displayPage(currentRouteName, context,
                                      sizingInformation),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: sizingInformation.screenSize.width * 0.05,
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      onTap: () {
                        setState(() {
                          cirAn = true;
                        });
                        themeChange.darkTheme = !themeChange.darkTheme;
                        if (animationController.status ==
                                AnimationStatus.forward ||
                            animationController.status ==
                                AnimationStatus.completed) {
                          animationController.reset();
                          animationController.forward();
                        } else {
                          animationController.forward();
                        }
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget displayPage(String currentRouteName, BuildContext context,
    SizingInformation sizingInformation) {
  if (currentRouteName == Routes.home)
    return HomeScreen(sizingInformation: sizingInformation);
  else if (currentRouteName == Routes.blogs)
    return BlogHomeScreen();
  else if (currentRouteName == Routes.whoAmI)
    return WhoAmI();
  //return WhoAmI();
  else if (currentRouteName == Routes.editor)
    return EditorScreen();
  else if (currentRouteName == Routes.login)
    return LoginScreen();
  else if (currentRouteName == Routes.userProfile)
    return UserProfile();
  else
    return Text("NO BUILT IT YET");
}

Widget myDrawer(Size boxSize, Function callback, bool isLogin) {
  return Drawer(
    child: NavBar(boxSize, callback, isLogin),
  );
}
