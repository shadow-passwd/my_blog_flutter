import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../widgets/text_field_widget.dart';
import '../../utils/api/api_calls.dart';
import '../../model/user_login.dart';
import '../../model/user.dart' as UserModel;
import '../../constants/images_location.dart';

class UserProfile extends StatefulWidget {
  UserProfile();
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final location = TextEditingController();

  final description = TextEditingController();

  MediaInfo profilePic;

  profileFunction() {
    pickProfileImage().then((mediaData) {
      setState(() {
        profilePic = mediaData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<UserModel.UserProfile>(
        future: userProfile(User.userId, User.accessToken, true),
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
                                    : MemoryImage(base64Decode(
                                        snapshot.data.profilePicBase64))
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
                  MaterialButton(
                      child: Text("Submit"),
                      onPressed: () {
                        upload(profilePic);
                        // userProfile(
                        //   User.userId,
                        //   User.accessToken,
                        //   false,
                        //   description: description.text,
                        //   location: location.text,
                        //   base64Image: profilePic.base64,
                        // ).then((value) {
                        //   print(value.location);
                        // });
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
