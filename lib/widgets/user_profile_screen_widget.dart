import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../utils/api/api_calls.dart';

import '../constants/images_location.dart';
import '../widgets/text_field_widget.dart';
import '../model/user_login.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? CircularProgressIndicator()
          : FutureBuilder<UserModel.UserProfile>(
              future: getUserProfile(User.userId, User.accessToken),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              User.username,
                              style: TextStyle(letterSpacing: 5),
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: profilePic == null
                                      ? snapshot.data == null
                                          ? AssetImage(ImageLocation.homeImage)
                                          : NetworkImage(
                                              snapshot.data.profilePic)
                                      : MemoryImage(profilePic.data),
                                  radius: 200.0,
                                ),
                                RaisedButton.icon(
                                    onPressed: profileFunction,
                                    icon: Icon(Icons.image),
                                    label: Text("Pick-Up Images")),
                              ],
                            ),
                          ],
                        ),
                        InputField(
                            description,
                            snapshot.data == null
                                ? 'Description ..'
                                : snapshot.data.description),
                        InputField(
                            location,
                            snapshot.data == null
                                ? 'Location'
                                : snapshot.data.location),
                        InputField(
                          githubIdUrl,
                          "Github",
                          minLines: 1,
                          icon: MyIcons.github,
                        ),
                        InputField(facebookIdUrl, "Facebook", minLines: 1),
                        InputField(
                          twitterIdUrl,
                          "Twitter",
                          minLines: 1,
                          icon: MyIcons.twitter,
                        ),
                        MaterialButton(
                            child: Text("Submit"),
                            onPressed: () {
                              // upload(profilePic);
                              isLoading = true;
                              userProfileCreation(
                                      User.userId,
                                      User.username,
                                      profilePic,
                                      coverImage,
                                      description.text,
                                      location.text,
                                      githubIdUrl.text,
                                      twitterIdUrl.text,
                                      facebookIdUrl.text,
                                      User.accessToken)
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
