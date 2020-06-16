import 'package:flutter/material.dart';

import 'dart:async';

import '../../ui/base_page/base_page.dart';
import '../../constants/images_location.dart';
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BasePage(),
    ));
  }
}

Center buildbody(BuildContext context) {
  return Center(
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 200),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "H e l l o \nF r i e n d s",
              style: mrRobotTheme.textTheme.headline6,
            ),
            Text('This site is still constructing'),
            Icon(
              Construction.construction,
              size: 40,
            ),
            Image.asset(ImageLocation.constPict),
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
    ),
  );
}
