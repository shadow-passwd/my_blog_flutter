import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../widgets/home_button.dart';
import '../routes.dart';

class NavBar extends StatelessWidget {
  final Function callback;
  final bool isLogin;
  final size;
  final Size boxSize;
  final String currentRouteName;
  final bool isDrawerOpened;
  final BuildContext drawerContext;
  NavBar(
    this.boxSize,
    this.callback,
    this.isLogin, {
    this.size,
    this.currentRouteName,
    this.isDrawerOpened = false,
    this.drawerContext,
  });
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      width: boxSize.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              HomeButton(
                text: 'Home',
                routeName: Routes.home,
                callback: callback,
                size: currentRouteName == Routes.home
                    ? size
                    : 30, //constraints.maxWidth * 0.4 * 0.2,
                boxSize: boxSize,
                drawerContext: drawerContext,
                isDrawerOpened: isDrawerOpened,
              ),
              SizedBox(
                height: 20,
              ),
              HomeButton(
                text: 'Blog',
                routeName: Routes.blogs,
                callback: callback,
                size: currentRouteName == Routes.blogs
                    ? size
                    : 30, //constraints.maxWidth * 0.4 * 0.2,
                boxSize: boxSize,
                drawerContext: drawerContext,
                isDrawerOpened: isDrawerOpened,
              ),
              SizedBox(
                height: 20,
              ),
              HomeButton(
                text: themeChange.isLogin ? 'Logout' : 'Login',
                routeName: themeChange.isLogin ? Routes.logout : Routes.login,
                callback: callback,
                size: currentRouteName == Routes.login ||
                        currentRouteName == Routes.logout
                    ? size
                    : 30, //constraints.maxWidth * 0.4 * 0.2,
                boxSize: boxSize,
                drawerContext: drawerContext,
                isDrawerOpened: isDrawerOpened,
              ),
              SizedBox(
                height: 20,
              ),
              HomeButton(
                text: 'Editor-Screen',
                routeName: Routes.editor,
                callback: callback,
                size: currentRouteName == Routes.editor
                    ? size
                    : 30, //constraints.maxWidth * 0.4 * 0.2,
                boxSize: boxSize,
                drawerContext: drawerContext,
                isDrawerOpened: isDrawerOpened,
              ),
              SizedBox(
                height: 20,
              ),
              HomeButton(
                text: 'Who-am-I',
                routeName: Routes.whoAmI,
                callback: callback,
                size: currentRouteName == Routes.whoAmI
                    ? size
                    : 30, //constraints.maxWidth * 0.4 * 0.2,
                boxSize: boxSize,
                drawerContext: drawerContext,
                isDrawerOpened: isDrawerOpened,
              ),
              isLogin == true
                  ? HomeButton(
                      text: 'MyProfile',
                      routeName: Routes.userProfile,
                      callback: callback,
                      size: currentRouteName == Routes.userProfile
                          ? size
                          : 30, //constraints.maxWidth * 0.4 * 0.2,
                      boxSize: boxSize,
                      drawerContext: drawerContext,
                      isDrawerOpened: isDrawerOpened,
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
