import 'package:flutter/material.dart';

import '../constants/images_location.dart';

class NetworkError extends StatelessWidget {
  final handler;
  NetworkError({this.handler});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Stack(children: [
        Image.asset(ImageLocation.networkErrorImage, fit: BoxFit.fill),
        Center(
          child: MaterialButton(
            onPressed: () {
              print("RELOAD PLEASE");
            },
            color: Colors.red,
            child: Text("ERROR OCCURRED, Tap to retry !"),
          ),
        ),
      ]),
    );
  }
}
