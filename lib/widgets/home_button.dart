import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../constants/font_family.dart';

class HomeButton extends StatelessWidget {
  final routeName;
  final text;
  final size;
  final Size boxSize;
  final Function callback;
  final isDrawerOpened;
  final BuildContext drawerContext;
  HomeButton({
    this.routeName,
    this.text,
    this.callback,
    this.size = 30,
    this.boxSize,
    this.drawerContext,
    this.isDrawerOpened = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: FlatButton(
        hoverColor: Theme.of(context).hoverColor,
        onPressed: () {
          callback(routeName, boxSize, drawerContext, isDrawerOpened);
        },
        child: AutoSizeText(
          text,
          style: TextStyle(fontFamily: FontFamily.balsamiqSans, fontSize: size),
          maxFontSize: 50,
          maxLines: 1,
        ),
        //color: Colors.yellow[900],
      ),
    );
  }
}
