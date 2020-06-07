import 'package:flutter/material.dart';

class Terminal extends StatelessWidget {
  const Terminal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      padding: EdgeInsets.all(50.0),
      color:Colors.blueGrey[700],
      height: 600,
      width: 600,
      child: Text(' > _ '),
    );
  }
}