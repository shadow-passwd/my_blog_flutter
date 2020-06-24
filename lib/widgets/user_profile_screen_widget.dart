import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:my_awesome_blog/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../utils/api/api_calls.dart';

import '../constants/images_location.dart';
import '../widgets/text_field_widget.dart';

import '../model/user.dart' as UserModel;

import '../constants/my_custom_icons.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen();
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final location = TextEditingController();
  final githubIdUrl = TextEditingController();
  final facebookIdUrl = TextEditingController();
  final twitterIdUrl = TextEditingController();
  final description = TextEditingController();

  MediaInfo profilePic;
  MediaInfo coverImage;

  bool isLoading = false;

  profileFunction() {
    pickProfileImage().then((mediaData) {
      setState(() {
        // print(mime(Path.basename(mediaData.fileName)));
        profilePic = mediaData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    print(themeChange.userId.toString());
    print(themeChange.accessToken.toString());
    print(themeChange.expiryTime.toString());
    print(themeChange.username.toString());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? CircularProgressIndicator()
          : FutureBuilder<UserModel.UserProfile>(
              future:
                  getUserProfile(themeChange.userId, themeChange.accessToken),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          // alignment: Alignment.bottomLeft,
                          overflow: Overflow.visible,
                          children: [
                            snapshot.data.profileCoverImage == null
                                ? Container(
                                    height: 400,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    color: _colors[
                                        Random().nextInt(_colors.length)],
                                    child: Text(
                                      "NO ARTICLE IMAGE",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  )
                                : Image.network(
                                    snapshot.data.profileCoverImage,
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                    fit: BoxFit.fill,
                                    // fit: BoxFit.contain,
                                  ),
                            Positioned(
                              top: 250,
                              right: 0,
                              left: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      themeChange.username == null
                                          ? "username"
                                          : themeChange.username,
                                      style: TextStyle(
                                          letterSpacing: 5,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: profilePic == null
                                            ? snapshot.data == null
                                                ? AssetImage(
                                                    ImageLocation.homeImage)
                                                : NetworkImage(
                                                    snapshot.data.profilePic)
                                            : MemoryImage(profilePic.data),
                                        radius: 200.0,
                                      ),
                                      RaisedButton.icon(
                                          onPressed: profileFunction,
                                          icon: Icon(
                                            Icons.image,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            "Pick-Up Images",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 400,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 600),
                          child: Column(
                            children: [
                              InputField(
                                  description,
                                  snapshot.data.description == null
                                      ? 'Description ..'
                                      : snapshot.data.description),
                              InputField(
                                  location,
                                  snapshot.data.location == null
                                      ? 'Location'
                                      : snapshot.data.location),
                              InputField(
                                githubIdUrl,
                                "Github",
                                minLines: 1,
                                icon: MyIcons.github,
                              ),
                              InputField(
                                facebookIdUrl,
                                "Facebook",
                                minLines: 1,
                                icon: MyIcons.facebook,
                              ),
                              InputField(
                                twitterIdUrl,
                                "Twitter",
                                minLines: 1,
                                icon: MyIcons.twitter,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                            child: Text("Submit"),
                            onPressed: () {
                              // upload(profilePic);
                              isLoading = true;
                              userProfileCreation(
                                      themeChange.userId,
                                      themeChange.username,
                                      profilePic,
                                      coverImage,
                                      description.text,
                                      location.text,
                                      githubIdUrl.text,
                                      twitterIdUrl.text,
                                      facebookIdUrl.text,
                                      themeChange.accessToken)
                                  .then((value) => print(value));
                            }),
                      ],
                    ),
                  );
                } else
                  return CircularProgressIndicator();
              },
            ),
    );
  }
}

List<Color> _colors = [
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.indigo,
  Colors.green,
  Colors.purple
];
