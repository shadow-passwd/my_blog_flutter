import 'package:flutter/material.dart';


import '../../routes.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.editor);
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => EditorPage(),
            // ));
          },
          child: Text("Click to Open Editor Screen")),
    );
  }
}
