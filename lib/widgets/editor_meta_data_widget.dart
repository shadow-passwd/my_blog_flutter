import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'text_field_widget.dart';
import '../constants/my_custom_icons.dart';
import 'editor_content_widget.dart';
import '../providers/dark_theme_provider.dart';

import '../utils/api/api_calls.dart';
import '../constants/CustomIcons/github_icons.dart';
import '../constants/CustomIcons/twitter_icons.dart';

class EditorMetaDataScreen extends StatefulWidget {
  @override
  _EditorMetaDataScreenState createState() => _EditorMetaDataScreenState();
}

class _EditorMetaDataScreenState extends State<EditorMetaDataScreen> {
  final title = TextEditingController();
  final genre = TextEditingController();
  final email = TextEditingController();
  final github = TextEditingController();
  final twitter = TextEditingController();
  final facebook = TextEditingController();
  final tags = TextEditingController();

  final _formMetaKey = GlobalKey<FormState>();

  FocusNode titleFocus;
  FocusNode genreFocus;
  FocusNode emailFocus;
  FocusNode githubFocus;
  FocusNode twitterFocus;
  FocusNode facebookFocus;
  FocusNode tagsFocus;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
    genreFocus = FocusNode();
    emailFocus = FocusNode();
    githubFocus = FocusNode();
    twitterFocus = FocusNode();
    facebookFocus = FocusNode();
    tagsFocus = FocusNode();
  }

  @override
  void dispose() {
    title.dispose();
    genre.dispose();
    email.dispose();
    github.dispose();
    twitter.dispose();
    facebook.dispose();
    tags.dispose();
    titleFocus.dispose();
    genreFocus.dispose();
    emailFocus.dispose();
    githubFocus.dispose();
    twitterFocus.dispose();
    facebookFocus.dispose();
    tagsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return isLoading
        ? CircularProgressIndicator()
        : Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formMetaKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    InputField(
                      title,
                      "Title",
                      minLines: 1,
                      autoFocus: true,
                      focusNode: titleFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(genreFocus);
                      },
                    ),
                    InputField(
                      genre,
                      "Genre",
                      minLines: 1,
                      focusNode: genreFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                    ),
                    InputField(
                      email,
                      "Email",
                      minLines: 1,
                      icon: MyIcons.email,
                      focusNode: emailFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(facebookFocus);
                      },
                    ),
                    InputField(
                      facebook,
                      "Facebook",
                      minLines: 1,
                      icon: MyIcons.facebook,
                      focusNode: facebookFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(twitterFocus);
                      },
                    ),
                    InputField(
                      twitter,
                      "Twitter",
                      minLines: 1,
                      icon: Twitter.twitter_bird,
                      focusNode: twitterFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(githubFocus);
                      },
                    ),
                    InputField(
                      github,
                      "Github",
                      minLines: 1,
                      icon: Github.github,
                      focusNode: githubFocus,
                      onFieldSubmitted: () {
                        FocusScope.of(context).requestFocus(tagsFocus);
                      },
                    ),
                    InputField(tags, 'Tags', minLines: 1),
                    FlatButton(
                      child: Text('Content page'),
                      onPressed: () {
                        if (!themeChange.isLogin)
                          showDialogBox(context);
                        else {
                          setState(() {
                            isLoading = true;
                          });
                          postMetaData(
                            title.text,
                            genre.text,
                            email.text,
                            facebook.text,
                            twitter.text,
                            github.text,
                            tags.text,
                            themeChange.userId,
                            themeChange.accessToken,
                          ).then((value) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => EditorContentPage(value),
                            ));
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

void showDialogBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Attention !!"),
        content: Text("u need to login for doing this"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'))
        ],
      );
    },
  );
}
