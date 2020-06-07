import 'package:flutter/material.dart';

import '../../model/user_login.dart';
import '../../constants/images_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

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
    return Column(
      children: [
        Row(
          children: [
            User.isLogin == true ? Text('Hello ' + User.username) : SizedBox(),
            MaterialButton(
                onPressed: null,
                child: Text(User.isLogin == false ? 'Login' : 'Logout')),
          ],
        ),
        Column(
          children: [
            Image.asset(
              ImageLocation.homeImage,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
