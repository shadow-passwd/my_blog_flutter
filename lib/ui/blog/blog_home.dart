import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../../widgets/network_error.dart';
import '../../providers/post_provider.dart';

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
  var provider;
  List<Post> posts;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      provider = Provider.of<Posts>(context);

      if (provider.isPostFetched == false) {
        provider.getPost().then((_) {
          setState(() {
            posts = provider.items;
          });
          return provider.items;
        });
      } else {
        setState(() {
          posts = provider.items;
        });
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: posts == null ? CircularProgressIndicator() : Child(posts),
      ),
    );
  }
}

class Child extends StatelessWidget {
  final List<Post> posts;
  Child(this.posts);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(20),
          width: 200,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, 'blog/' + posts[index].id.toString());
            },
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(posts[index].title),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.amber,
                        child: Text("Open Post"),
                      ),
                    ],
                  ),
                ],
              ),
              // child: ListTile(
              //   title: Text(posts[index].title),
              // ),
            ),
          ),
        );
      },
    );
  }
}
