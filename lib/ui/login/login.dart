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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  FocusNode usernameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;

  // var timer=Timer.periodic(Duration(seconds: User.), (timer) { })

  loadingCallback(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    super.initState();

    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 600),
              child: !haveAccount
                  ? Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            username,
                            "Username",
                            autoFocus: true,
                            validator: (value) => usernameValidator(value),
                            focusNode: usernameFocus,
                            onFieldSubmitted: () {
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                          ),
                          InputField(
                            email,
                            "Email",
                            focusNode: emailFocus,
                            validator: (value) => emailValidator(value),
                            onFieldSubmitted: () {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                          ),
                          InputField(password, "Password",
                              focusNode: passwordFocus,
                              validator: (value) => passwordValidator(value)),
                          MaterialButton(
                            child: Text("Regsiter"),
                            onPressed: () {
                              saveRegistrationForm(
                                  _formKey,
                                  isLoading,
                                  loadingCallback,
                                  context,
                                  username.text,
                                  password.text,
                                  email.text,
                                  themeChange);
                            },
                          ),
                          MaterialButton(
                              child: Text("Have Account"),
                              onPressed: () {
                                setState(() {
                                  haveAccount = true;
                                });
                              }),
                        ],
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            username,
                            "Username",
                            labelText: "Username",
                            autoFocus: true,
                            validator: (value) => usernameValidator(value),
                            focusNode: usernameFocus,
                            onFieldSubmitted: () {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                          ),
                          InputField(password, "Password",
                              labelText: "Password",
                              focusNode: passwordFocus,
                              validator: (value) => passwordValidator(value)),
                          MaterialButton(
                            child: Text("Log In"),
                            onPressed: () {
                              saveLoginForm(
                                _formKey,
                                isLoading,
                                loadingCallback,
                                context,
                                username.text,
                                password.text,
                                themeChange,
                              );
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
            ),
    );
  }
}

saveLoginForm(
  GlobalKey<FormState> _formKey,
  bool isLoading,
  Function loadingCallback,
  BuildContext context,
  String username,
  String password,
  DarkThemeProvider themeChange,
) {
  final isValid = _formKey.currentState.validate();
  if (!isValid) return;

  loadingCallback(true);
  print(username);
  userLogin(username, password).then((token) {
    //addStringToSF(token);
    var values = token.split(':');
    themeChange.setLoginValues(true, values[1], values[2], int.parse(values[0]),
        double.parse(values[3]).toInt());
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SplashScreen(),
    ));
    //saveAuthToken(token);
  });
}

saveRegistrationForm(
  GlobalKey<FormState> _formKey,
  bool isLoading,
  Function loadingCallback,
  BuildContext context,
  String username,
  String password,
  String email,
  DarkThemeProvider themeChange,
) {
  final isValid = _formKey.currentState.validate();
  if (!isValid) return;

  loadingCallback(true);
  // setState(() {
  //   isLoading = true;
  // });
  userRegistration(username, email, password).then((val) {
    print("++++++++++++++++++ ${val.toString()}");
    userLogin(username, password).then((token) {
      var values = token.split(':');
      themeChange.setLoginValues(true, values[1], values[2],
          int.parse(values[0]), double.parse(values[3]).toInt());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ));
    });
  });
}

String usernameValidator(String value) {
  return null;
}

String passwordValidator(String value) {
  return null;
}

String emailValidator(String value) {
  return null;
}
