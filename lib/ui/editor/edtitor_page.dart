import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/editor_meta_data_widget.dart';

import '../../providers/editor_image_provider.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<Images>(builder: (context, value, child) {
      return EditorMetaDataScreen();
    }));
  }
}
