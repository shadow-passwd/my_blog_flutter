import 'package:flutter/material.dart';

import '../constants/font_family.dart';
import '../constants/CustomIcons/my_flutter_app_icons.dart';
import '../constants/CustomIcons/github_icons.dart';
import '../constants/CustomIcons/twitter_icons.dart';

class TopBar extends StatelessWidget {
  final Size boxSize;
  TopBar({this.boxSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: boxSize.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
              ),
              Container(
                  child: IconButton(
                      icon: Icon(MyFlutterApp.terminal), onPressed: () {})),
              VerticalDivider(),
              Container(
                  child: Text(
                'Shadow',
                style:
                    TextStyle(fontSize: 35, fontFamily: FontFamily.hackedKerX),
              )),
            ],
          ),
          Row(
            children: [
              IconButton(icon: Icon(Github.github), onPressed: () {}),
              IconButton(icon: Icon(Twitter.twitter_bird), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
