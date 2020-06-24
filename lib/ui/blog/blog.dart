import 'package:flutter/material.dart';
import 'package:markdown_widget/config/highlight_themes.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:my_awesome_blog/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/urls.dart';
import '../../model/single_post.dart';
import '../../utils/api/api_calls.dart';
import '../../constants/my_custom_icons.dart';
import '../../constants/font_family.dart';

class BlogScreen extends StatefulWidget {
  final String blogId;

  BlogScreen(this.blogId);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final TocController controller = TocController();
  bool isInit = true;
  bool isDark;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
      });
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOG"),
      ),
      body: FutureBuilder<SinglePost>(
        future: getSinglePost(int.parse(widget.blogId)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SinglePost post = snapshot.data;
            print(
                "-----------------------------------------------------------------------------");
            print(isDark.toString());
            print(
                "-----------------------------------------------------------------------------");

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(post.userProfilePic),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(post.username),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(MyIcons.facebook),
                                    onPressed: () {
                                      launchURL(post.facebookIdUrl);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(MyIcons.github),
                                    onPressed: () {
                                      launchURL(post.githubIdUrl);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(MyIcons.twitter),
                                    onPressed: () {
                                      launchURL(post.twitterIdUrl);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(MyIcons.email),
                                    onPressed: () {
                                      launchURL(post.emailIdUrl);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(post.datePosted.toString()),
                        ],
                      ),
                    ),
                    post.postCoverImage == null
                        ? SizedBox()
                        : Image.network(
                            post.postCoverImage,
                            // height: 500,
                            // fit: BoxFit.cover,
                          ),
                    buildMarkDown(snapshot, isDark, controller),
                  ],
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

Container buildMarkDown(AsyncSnapshot<SinglePost> snapshot, bool darkTheme,
    TocController controller) {
  print(darkTheme);
  return Container(
    height: 1000,
    child: Row(
      children: [
        Expanded(
          child: TocListWidget(controller: controller),
        ),
        Expanded(
          flex: 3,
          child: MarkdownWidget(
            data: snapshot.data.content,
            controller: controller,
            styleConfig: StyleConfig(
              markdownTheme: theme(darkTheme),
              imgBuilder: (String url, attributes) {
                return Image.network(
                    Urls.imageUrl + '${snapshot.data.id}/' + url);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

theme(bool isDark) {
  const light_theme = {
    'PStyle': TextStyle(color: Color(0xff1E2226)),
    'CodeStyle': TextStyle(fontSize: 12, color: Color(0xff1E2226)),
    'BlockStyle': TextStyle(color: Color(0xffA9AAB4)),
    'CodeBackground': Color(0xffF5F5F5),
    'TableBorderColor': Color(0xffD7DBDF),
    'DividerColor': Color(0xffE5E6EB),
    'BlockColor': Color(0xffD7DBDF),
    'PreBackground': Color(0xffF3F6F9),
    'TitleColor': Color(0xff000000),
    'UlDotColor': Color(0xff000000),
    'HightLightCodeTheme': arduinoLightTheme,
  };

  const dark_theme = {
    'PStyle': TextStyle(color: Color(0xffFAFAFA)),
    'CodeStyle': TextStyle(fontSize: 12, color: Color(0xffFAFAFA)),
    'BlockStyle': TextStyle(color: Color(0xffFAFAFA)),
    'CodeBackground': Color(0xff555555),
    'TableBorderColor': Color(0xffD7DBDF),
    'DividerColor': Color(0xFF646464),
    'BlockColor': Color(0xff646464),
    'PreBackground': Color(0xff555555),
    'TitleColor': Color(0xffFAFAFA),
    'UlDotColor': Color(0xffFAFAFA),
    'HightLightCodeTheme': darkTheme,
  };

  return isDark ? dark_theme : light_theme;
}
