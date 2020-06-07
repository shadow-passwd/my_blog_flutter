import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final routeName;
  final text;
  Function callback;
  HomeButton({this.routeName, this.text, this.callback});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        callback(routeName);
      },
      child: Text(
        text,
      ),
      //color: Colors.yellow[900],
    );
  }
}
