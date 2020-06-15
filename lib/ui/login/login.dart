import 'package:flutter/material.dart';

import '../../ui/splash/splash.dart';
import '../../routes.dart';
import '../../ui/home/home.dart';
import '../../widgets/text_field_widget.dart';
import '../../utils/api/api_calls.dart';
import '../../data/shared.dart';
import '../../model/user_login.dart';
import '../../utils/api/api_calls.dart';

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

  @override
  Widget build(BuildContext context) {
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
                                  addStringToSF(token);
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
                              addStringToSF(token);
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
