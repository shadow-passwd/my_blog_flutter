import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../ui/editor/image_load.dart';
import 'text_field_widget.dart';
import '../utils/api/api_calls.dart';
import 'package:provider/provider.dart';

import 'base_widget.dart';
import '../providers/editor_image_provider.dart';

class EditorContentPage extends StatelessWidget {
  final int postId;
  EditorContentPage(this.postId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildEditor(postId),
    );
  }
}

class BuildEditor extends StatefulWidget {
  final int postId;
  BuildEditor(this.postId);
  @override
  _BuildEditorState createState() => _BuildEditorState();
}

class _BuildEditorState extends State<BuildEditor> {
  final content = TextEditingController();

  TextEditingController previewcontroller = TextEditingController();

  final controller = ScrollController();

  Future<String> preview;
  String data;
  String previewContent = "Text Preview";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    content.addListener(() {
      setState(() {
        previewContent = content.text != null ? content.text : "Text Preview";
      });
    });
  }

  @override
  void dispose() {
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Images>(context);
    return BaseWidget(
      builder: (context, sizingInformation) {
        return buildWiget(provider, widget.postId);
      },
    );
  }

  Center buildWiget(Images provider, int postId) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ImageLoad(provider),
                  MaterialButton(
                      child: Text("Send Image to server"),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        postImageData(provider, postId).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InputField(
                          content,
                          "Content",
                          minLines: 4,
                          maxLines: null,
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.pink)),
                            child: Markdown(
                              selectable: true,
                              data: previewContent,
                              controller: controller,
                              imageBuilder: (uri) {
                                print("-------------------" +
                                    uri.toFilePath().toString());
                                return Image.memory(provider
                                    .giveMediaData(uri.toFilePath().toString())
                                    .data);
                              },
                            ),
                          )),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        preview = Future.value(content.text);
                      });
                    },
                    child: Text('PREVIEW'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      postContentData(content.text, postId).then((value) {
                        isLoading = false;
                      });
                    },
                    child: Text("HIT ME"),
                  ),
                ],
              ),
            ),
    );
  }
}
