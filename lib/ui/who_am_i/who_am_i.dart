import 'package:flutter/material.dart';

import '../terminal/terminal.dart';

class WhoAmI extends StatelessWidget {
  const WhoAmI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
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
    );
  }
}
