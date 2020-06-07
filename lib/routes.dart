import 'package:flutter/material.dart';

import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';
import 'ui/terminal/terminal.dart';
import 'ui/blog/blog_home.dart';
import 'ui/editor/editor.dart';

class Routes {
  Routes._();

  static const splash = '';
  static const home = '/home';
  static const login = '/login';
  static const blogs = '/home/blogs';
  static const terminal = '/home/terminal';
  static const editor = '/home/blog/editor';
  static const whoAmI = '/home/blog/whoAmi';
  static const singleBlog = '/blog/:blogId';
  static const blogId = 'blogId';
  static const basePage = '/base';
  static const userProfile = '/profile';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    terminal: (BuildContext context) => TerminalScreen(),
    blogs: (BuildContext context) => BlogHomeScreen(),
  };
}
