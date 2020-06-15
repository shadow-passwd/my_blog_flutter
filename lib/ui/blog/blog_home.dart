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
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.9 * 0.3,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () {
            Navigator.pushNamed(context, 'blog/' + posts[index].id.toString());
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),

            height: MediaQuery.of(context).size.width * 0.9 * 0.3,
            decoration: BoxDecoration(
              color: _colors[Random().nextInt(_colors.length)],
              borderRadius: BorderRadius.circular(30.0),
            ),
            width: MediaQuery.of(context).size.width * 0.9 * 0.3,
            child: Text(posts[index].title),

            // child: ListTile(
            //   title: Text(posts[index].title),
            // ),
          ),
        );
      },
    );
  }
}

List<MaterialColor> _colors = [
  Colors.amber,
  Colors.orange,
  Colors.red,
  Colors.blue,
  Colors.pink,
  Colors.yellow,
  Colors.purple,
  Colors.green,
  Colors.cyan,
  Colors.teal,
  Colors.indigo,
];
