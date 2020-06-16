import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/splash/splash.dart';
import '../../widgets/text_field_widget.dart';
import '../../utils/api/api_calls.dart';

import '../../providers/dark_theme_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();

  final password = TextEditingController();
  final email = TextEditingController();
  bool haveAccount = true;

  bool isLoading = false;

  // var timer=Timer.periodic(Duration(seconds: User.), (timer) { })

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : Container(
              child: !haveAccount
                  ? Column(
                      children: [
                        InputField(username, "Username"),
                        InputField(email, "Email"),
                        InputField(password, "Password"),
                        MaterialButton(
                            child: Text("Regsiter"),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              userRegistration(
                                      username.text, email.text, password.text)
                                  .then((_) {
                                userLogin(username.text, password.text)
                                    .then((token) {
                                  var values = token.split(':');
                                  themeChange.setLoginValues(
                                      true,
                                      values[1],
                                      values[2],
                                      int.parse(values[0]),
                                      double.parse(values[3]).toInt());
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  ));
                                });
                              });
                            }),
                        MaterialButton(
                            child: Text("Have Account"),
                            onPressed: () {
                              setState(() {
                                haveAccount = true;
                              });
                            }),
                      ],
                    )
                  : Column(
                      children: [
                        InputField(username, "Username"),
                        InputField(password, "Password"),
                        MaterialButton(
                          child: Text("Log In"),
                          onPressed: () {
                            print(username.text);
                            userLogin(username.text, password.text)
                                .then((token) {
                              //addStringToSF(token);
                              var values = token.split(':');
                              themeChange.setLoginValues(
                                  true,
                                  values[1],
                                  values[2],
                                  int.parse(values[0]),
                                  double.parse(values[3]).toInt());
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SplashScreen(),
                              ));
                              //saveAuthToken(token);
                            });
                          },
                        ),
                        MaterialButton(
                            child: Text("Don't have Account"),
                            onPressed: () {
                              setState(() {
                                haveAccount = false;
                              });
                            }),
                      ],
                    ),
            ),
    );
  }
}
