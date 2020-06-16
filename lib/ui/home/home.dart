import 'package:flutter/material.dart';

import '../../utils/sizing_information.dart';
import '../../constants/images_location.dart';

class HomeScreen extends StatefulWidget {
  final SizingInformation sizingInformation;
  HomeScreen({this.sizingInformation});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool pressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          ImageLocation.homeImage,
          fit: BoxFit.contain,
          // height: widget.sizingInformation.localWidgetSize.height * 0.7,
          width: widget.sizingInformation.localWidgetSize.width * 0.65,
        ),
      ),
    );
  }
}
