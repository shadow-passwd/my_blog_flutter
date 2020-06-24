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
  final labelText;
  final Function validator;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final bool autoFocus;
  InputField(
    this.controller,
    this.hinttext, {
    this.minLines,
    this.maxLines = 1,
    this.sizingInformation,
    this.obscure = false,
    this.icon,
    this.labelText,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        
        autofocus: autoFocus,
        controller: controller,
        focusNode: focusNode,
        validator: (value) => validator(value),
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscure,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => onFieldSubmitted(),
        style: TextStyle(
          color: themeChange.darkTheme ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: themeChange.darkTheme ? Colors.white : Colors.black,
          ),
          filled: true,
          prefixIcon: Icon(
            icon,
          ),
          hintStyle: TextStyle(
            color: themeChange.darkTheme ? Colors.white : Colors.black,
          ),
          hintText: hinttext,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
