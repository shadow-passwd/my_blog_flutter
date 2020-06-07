import 'package:flutter/material.dart';

import '../widgets/home_button.dart';
import '../routes.dart';
import '../data/shared.dart';
import '../ui/splash/splash.dart';
import '../model/user_login.dart';

class NavBar extends StatelessWidget {
  Function callback;
  bool isLogin;
  NavBar(this.callback, this.isLogin);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeButton(
                text: 'Home', routeName: Routes.home, callback: callback),
            HomeButton(
                text: 'Blog', routeName: Routes.blogs, callback: callback),
            User.isLogin
                ? MaterialButton(
                    onPressed: () {
                      logoutFunc(context);
                    },
                    child: Text(
                      'Logout',
                    ),
                    //color: Colors.yellow[900],
                  )
                : HomeButton(
                    text: User.isLogin ? 'Logout' : 'Login',
                    routeName: Routes.login,
                    callback: callback),
            HomeButton(
                text: 'Editor-Screen',
                routeName: Routes.editor,
                callback: callback),
            HomeButton(
                text: 'Who-am-I', routeName: Routes.whoAmI, callback: callback),
            isLogin == true
                ? HomeButton(
                    text: 'MyProfile',
                    routeName: Routes.userProfile,
                    callback: callback,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

logoutFunc(BuildContext context) {
  removeValues();
  User.isLogin = false;
  User.username = null;
  User.accessToken = null;
  User.userId = null;
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => SplashScreen(),
  ));
}
