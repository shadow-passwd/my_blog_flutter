import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  TextEditingController controller;
  int minLines, maxLines = 1;
  String hinttext;

  InputField(this.controller, this.hinttext, {this.minLines, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hinttext,
        ),
      ),
    );
  }
}
