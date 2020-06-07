import 'package:flutter/material.dart';

import '../terminal/terminal.dart';

class WhoAmI extends StatelessWidget {
  const WhoAmI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shadow",
                      style: TextStyle(letterSpacing: 5),
                    ),
                    CircleAvatar(
                      child: Icon(Icons.image),
                      radius: 100,
                    ),
                  ],
                ),
                TerminalScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
