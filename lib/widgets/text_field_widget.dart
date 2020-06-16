import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/sizing_information.dart';
import '../providers/dark_theme_provider.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final int minLines, maxLines;
  final String hinttext;
  final bool obscure;
  final IconData icon;
  final SizingInformation sizingInformation;
  InputField(
    this.controller,
    this.hinttext, {
    this.minLines,
    this.maxLines = 1,
    this.sizingInformation,
    this.obscure = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          obscureText: obscure,
          style: TextStyle(
            color: themeChange.darkTheme ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            icon: Icon(icon),
            hintStyle: TextStyle(
              color: themeChange.darkTheme ? Colors.white : Colors.black,
            ),
            hintText: hinttext,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
