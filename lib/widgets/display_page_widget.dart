import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

import '../utils/sizing_information.dart';
import '../routes.dart';
import '../ui/home/home.dart';
import '../ui/blog/blog_home.dart';
import '../ui/editor/editor.dart';
import '../ui/who_am_i/who_am_i.dart';
import '../ui/userProfile/user_profile.dart';
import '../ui/login/login.dart';

Widget displayPage(String currentRouteName, BuildContext context,
    SizingInformation sizingInformation) {
  return Container(
    width: sizingInformation.localWidgetSize.width * 0.75,
    height: sizingInformation.localWidgetSize.height * 0.7,
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: displayPageRoute(currentRouteName, context, sizingInformation),
    ),
  );
}

Widget displayPageRoute(String currentRouteName, BuildContext context,
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
  else if (currentRouteName == Routes.logout) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    Future.delayed(Duration.zero).then((_) {
      themeChange.unSetLoginValues();
    });
    return LoginScreen();
  } else
    return Text("NO BUILT IT YET");
}
