import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:markdown_widget/markdown_widget.dart' as TOC;

import '../../model/post.dart';
import '../../constants/urls.dart';
import '../../model/single_post.dart';
import '../../utils/api/api_calls.dart';
import '../../providers/post_provider.dart';

class BlogScreen extends StatelessWidget {
  final String blogId;
  //final controller = ScrollController();
  final TOC.TocController controller = TOC.TocController();

  BlogScreen(this.blogId);

//TODO:ADD SINGLE USER POST FETCH API IN DJNAGO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOG"),
      ),
      body: FutureBuilder<SinglePost>(
        future: getSinglePost(int.parse(blogId)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("http://127.0.0.1:8000/images/post_images/" +
                '${snapshot.data.user}/${snapshot.data.id}/');
            return Row(
              children: [
                Expanded(
                  child: TOC.TocListWidget(controller: controller),
                ),
                Expanded(
                  flex: 3,
                  child: TOC.MarkdownWidget(
                    data: snapshot.data.content,
                    controller: controller,
                    styleConfig: TOC.StyleConfig(
                      imgBuilder: (String url, attributes) {
                        return Image.network(
                            Urls.imageUrl + '${snapshot.data.id}/' + url);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
