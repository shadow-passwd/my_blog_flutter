import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../providers/editor_image_provider.dart';
import '../../providers/post_provider.dart';
import '../../utils/api/api_calls.dart';
import '../../widgets/text_field_widget.dart';
import 'image_load.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Images>(
      builder: (context, value, child) {
        return BuildEditor();
      },
    );
  }
}

class BuildEditor extends StatefulWidget {
  @override
  _BuildEditorState createState() => _BuildEditorState();
}

class _BuildEditorState extends State<BuildEditor> {
  final title = TextEditingController();

  final genre = TextEditingController();

  final description = TextEditingController();
  TextEditingController previewcontroller = TextEditingController();

  final controller = ScrollController();

  Future<String> preview;
  String data;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Images>(context);

    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ImageLoad(provider),
            InputField(title, "Title", minLines: 1),
            InputField(genre, "Genre", minLines: 1),
            InputField(description, "Description", minLines: 4, maxLines: null),
            MaterialButton(
              onPressed: () {
                setState(() {
                  preview = Future.value(description.text);
                });
              },
              child: Text('PREVIEW'),
            ),
            MaterialButton(
              onPressed: () {
                createPost(
                    title.text, genre.text, description.text, provider.data);
              },
              child: Text("HIT ME"),
            ),
            FutureBuilder(
              initialData: "NO TEXT",
              future: preview,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MarkdownBody(
                    selectable: true,
                    data: snapshot.data,
                    //controller: controller,
                    imageBuilder: (uri) {
                      print(
                          "-------------------" + uri.toFilePath().toString());
                      return Image.memory(provider
                          .giveMediaData(uri.toFilePath().toString())
                          .data);
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("NO DATA"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
