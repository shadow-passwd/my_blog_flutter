import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/shared_dark_theme.dart';
import '../main.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool _isLogin = false;
  String _username;
  String _accessToken;
  int _userId;
  int _expiryTime;

  bool get darkTheme => _darkTheme;
  bool get isLogin => _isLogin;
  String get username => _username;
  String get accessToken => _accessToken;
  int get userId => _userId;
  int get expiryTime => _expiryTime;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  void setLoginValues(bool isLogin, String username, String accessToken,
      int userId, int expiryTime) {
    _isLogin = isLogin;
    _userId = userId;
    _accessToken = accessToken;
    _expiryTime = expiryTime;
    _username = username;
    notifyListeners();
    startTimer();
  }

  void unSetLoginValues() {
    _isLogin = false;
    _username = null;
    _userId = null;
    _expiryTime = null;
    notifyListeners();
  }

  void startTimer() async {
    Timer(Duration(seconds: _expiryTime - 60), () {
      if (_isLogin) {
        print("TIME EXPIRED");

        showDialogBox();
        unSetLoginValues();
      }
    });
  }

  void startBeforeExpiryTime() async {
    Timer(Duration(seconds: 70 - 60), () {
      if (_isLogin) {
        print("TIME EXPIRED");

        showDialogBox();
      }
    });
  }
}

void showDialogBox() {
  showDialog(
    context: navigatorKey.currentState.overlay.context,
    builder: (context) {
      return AlertDialog(
        title: Text("Attention !!"),
        content: Text("u need to login for doing this"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'))
        ],
      );
    },
  );
}
