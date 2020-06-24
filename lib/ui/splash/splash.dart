import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_awesome_blog/constants/font_family.dart';

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
      child: Column(
        children: <Widget>[
          Spacer(),
          // Expanded(
          //   child: SizedBox(
          //     width: 250.0,
          //     child: ScaleAnimatedTextKit(
          //         onTap: () {
          //           print("Tap Event");
          //         },
          //         text: ["Hello", "Friends"],
          //         textStyle: mrRobotTheme.textTheme.headline6,
          //         textAlign: TextAlign.start,
          //         alignment:
          //             AlignmentDirectional.topStart // or Alignment.topLeft
          //         ),
          //   ),
          // ),
          Expanded(
            child: SizedBox(
              width: 250.0,
              child: ColorizeAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Shadow".toUpperCase(),
                    "Rishu".toUpperCase(),
                  ],
                  textStyle:
                      TextStyle(fontSize: 50.0, fontFamily: FontFamily.mrrobot),
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 250.0,
              child: TypewriterAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  speed: Duration(milliseconds: 200),
                  text: [
                    'This site is still constructing',
                  ],
                  textStyle: TextStyle(
                      fontSize: 50.0,
                      fontFamily: FontFamily.balsamiqSans,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),
          ),
          Icon(
            Construction.construction,
            size: 40,
          ),
          Spacer(),
        ],
      ),
    ),
  );
}
