import 'package:flutter/material.dart';

import '../widgets/home_button.dart';
import '../routes.dart';
import '../data/shared.dart';
import '../ui/splash/splash.dart';
import '../model/user_login.dart';

import '../constants/font_family.dart';

class NavBar extends StatelessWidget {
  final Function callback;
  final bool isLogin;
  final size;
  final Size boxSize;
  final String currentRouteName;
  NavBar(
    this.boxSize,
    this.callback,
    this.isLogin, {
    this.size,
    this.currentRouteName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      width: boxSize.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeButton(
            text: 'Home',
            routeName: Routes.home,
            callback: callback,
            size: currentRouteName == Routes.home
                ? size
                : 30, //constraints.maxWidth * 0.4 * 0.2,
            boxSize: boxSize,
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
          ),
          SizedBox(
            height: 20,
          ),
          User.isLogin
              ? MaterialButton(
                  onPressed: () {
                    logoutFunc(context);
                  },
                  child: Text(
                    'Logout',
                  ),
                  //color: Colors.yellow[900],
                )
              : HomeButton(
                  text: User.isLogin ? 'Logout' : 'Login',
                  routeName: Routes.login,
                  callback: callback,
                  size: currentRouteName == Routes.login
                      ? size
                      : 30, //constraints.maxWidth * 0.4 * 0.2,
                  boxSize: boxSize,
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
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

logoutFunc(BuildContext context) {
  removeValues();
  User.isLogin = false;
  User.username = null;
  User.accessToken = null;
  User.userId = null;
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => SplashScreen(),
  ));
}
