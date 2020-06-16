import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'text_field_widget.dart';
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

  bool isLoading = false;

  @override
  void dispose() {
    title.dispose();
    genre.dispose();
    email.dispose();
    github.dispose();
    twitter.dispose();
    facebook.dispose();
    tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return isLoading
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                InputField(title, "Title", minLines: 1),
                InputField(genre, "Genre", minLines: 1),
                InputField(email, "Email", minLines: 1),
                InputField(facebook, "Facebook", minLines: 1),
                InputField(twitter, "Twitter",
                    minLines: 1, icon: Twitter.twitter_bird),
                InputField(github, "Github", minLines: 1, icon: Github.github),
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
                              tags.text)
                          .then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => EditorContentPage(value),
                        ));
                      });
                    }
                  },
                ),
              ],
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