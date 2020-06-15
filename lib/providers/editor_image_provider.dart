import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class Images with ChangeNotifier {
  Map<String, MediaInfo> _images = Map<String, MediaInfo>();

  List<MediaInfo> get items {
    return [..._images.values];
  }

  Map<String, MediaInfo> get data {
    return {..._images};
  }

  MediaInfo giveMediaData(String filename) {
    return _images[filename];
  }

  void addMediaData(String filename, MediaInfo mediaData) {
    _images[filename] = mediaData;
    notifyListeners();
  }

  void addPostMetaData(String email, String github, String facebook,
      String twitter, String title, String genre, String tags) {}
}
