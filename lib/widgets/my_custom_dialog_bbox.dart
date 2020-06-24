import 'package:flutter/material.dart';

void showCustomDialogBox(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: null,
          onPressed: () {},
        ),
        FlatButton(
          child: null,
          onPressed: null,
        )
      ],
    ),
  );
}
