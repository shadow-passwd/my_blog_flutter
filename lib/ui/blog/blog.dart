import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../../constants/urls.dart';
import '../../utils/api/api_calls.dart';
import '../../providers/post_provider.dart';

class BlogScreen extends StatelessWidget {
  final String blogId;
  final controller = ScrollController();

  BlogScreen(this.blogId);

//TODO:ADD SINGLE USER POST FETCH API IN DJNAGO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOG"),
      ),
      body: FutureBuilder<Post>(
        future: singlePost(blogId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("http://127.0.0.1:8000/images/post_images/" +
                '${snapshot.data.user}/${snapshot.data.id}/');
            return Markdown(
              controller: controller,
              imageDirectory:
                  Urls.imageUrl + '${snapshot.data.user}/${snapshot.data.id}/',
              data: snapshot.data.description,
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
