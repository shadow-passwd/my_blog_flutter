import 'package:flutter/material.dart';

import 'dart:math';

import '../../model/post.dart';
import '../../utils/api/api_calls.dart';

class BlogHomeScreen extends StatefulWidget {
  const BlogHomeScreen({Key key}) : super(key: key);

  @override
  _BlogHomeScreenState createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  final textcontroller = TextEditingController();
  var isInit = true;

  Future<String> button;
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Child(snapshot.data);
              } else if (snapshot.hasError) {
                return ErrorWidget(snapshot.error);
              } else {
                return CircularProgressIndicator();
              }
            } else
              return CircularProgressIndicator();
          },
        ));
  }
}
// posts == null ? CircularProgressIndicator() : Child(posts),

class Child extends StatelessWidget {
  final List<Post> posts;
  Child(this.posts);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        print((MediaQuery.of(context).size.width * 0.9 * 0.3).toString());
        return LayoutBuilder(
          builder: (context, constraints) {
            return buildGrid(context, index, constraints, posts);
          },
        );
      },
    );
  }
}

InkWell buildGrid(BuildContext context, int index, BoxConstraints constraints,
    List<Post> posts) {
  return InkWell(
    borderRadius: BorderRadius.circular(30.0),
    onTap: () {
      Navigator.of(context).pushNamed('blog/' + posts[index].id.toString());
    },
    child: Card(
      elevation: 3,
      child: Container(
        constraints: constraints,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            posts[index].postCoverImage == null
                ? Container(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth,
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    color: _colors[Random().nextInt(_colors.length)],
                    child: Text(
                      "NO ARTICLE IMAGE",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : Container(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth,
                    child: Image.network(
                      posts[index].postCoverImage,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(posts[index].title,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(posts[index]
                    .content
                    .substring(0, min(30, posts[index].content.length))),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(posts[index].userProfilePic),
                  ),
                  Spacer(),
                  Text(posts[index].username),
                  Spacer(),
                ],
              ),
            ),
            Container(
              width: constraints.maxWidth,
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: Text(
                posts[index].tags,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
