import 'package:flutter/material.dart';

import '../../ui/home/home.dart';
import '../../ui/login/login.dart';
import '../../ui/who_am_i/who_am_i.dart';
import '../../ui/userProfile/user_profile.dart';
import '../../ui/blog/blog_home.dart';
import '../../ui/editor/editor.dart';
import '../../model/user_login.dart';

import '../../widgets/navbar_widget.dart';
import '../../routes.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  String currentRouteName = Routes.home;

  void callback(String route) {
    setState(() {
      currentRouteName = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: [
              NavBar(
                callback,
                User.isLogin,
              ),
              displayPage(currentRouteName, context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget displayPage(String currentRouteName, BuildContext context) {
  if (currentRouteName == Routes.home)
    return HomeScreen();
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
