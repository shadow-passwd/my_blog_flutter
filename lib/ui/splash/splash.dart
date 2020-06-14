import 'package:flutter/material.dart';

import 'dart:async';

import '../../routes.dart';
import '../../ui/base_page/base_page.dart';
import '../../data/shared.dart';
import '../../model/user_login.dart';
import '../../constants/app_theme.dart';
import '../../constants/CustomIcons/construction_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey[900],
      body: buildbody(context),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 5000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    checkKeyIsPresent().then((val) {
      print("VALUE IS---------" + val.toString());
      if (val == true) {
        getStringValuesSF().then((token) {
          setState(() {
            print("TOKEN----------" + token);
            User.isLogin = true;
            User.username = token.split(':')[1];
            User.userId = int.parse(token.split(':')[0]);
            print("USERNAME +++----" + User.username);
            User.accessToken = token.split(':')[2];
          });
        });
      }
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BasePage(),
    ));
    // Navigator.pushReplacementNamed(context, '/home');
  }
}

Center buildbody(BuildContext context) {
  return Center(
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 200),
      child: Column(
        children: <Widget>[
          Text(
            "H e l l o \nF r i e n d s",
            style: mrRobotTheme.textTheme.headline6,
          ),
          Row(
            children: [
              Text('This site is still constructing'),
              Icon(
                Construction.construction,
                size: 40,
              ),
            ],
          ),
          Container(
            //color: Colors.grey[900],
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2,
              child: RichText(
                text: TextSpan(
                    text: '\$ You know what ',
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Everyone lies',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
