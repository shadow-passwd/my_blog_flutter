import 'package:flutter/material.dart';

import '../../model/terminal.dart';
import '../../constants/app_theme.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({Key key}) : super(key: key);

  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  String text = "";
  final promt = 'root:~\$';
  final textcontroller = TextEditingController();
  String item, sub;
  int i;

  @override
  Widget build(BuildContext context) {
    return buildbody();
  }

  Center buildbody() {
    return Center(
      child: Container(
        height: 700,
        width: 900,
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.topLeft,
        color: Colors.purple[900],
        child: Column(
          children: [
            text.length == 0
                ? SizedBox()
                : Container(
                    alignment: Alignment.topLeft,
                    child: DefaultTextStyle(
                      style: terminalTheme.textTheme.headline2,
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          for (item in text.split(" ")) ...[
                            for (i = 0;
                                i < (item.split('\n')).length - 1;
                                i++) ...[
                              (item.split('\n'))[i] == promt
                                  ? TextSpan(
                                      text: (item.split('\n'))[i] + '\n',
                                      style: terminalTheme.textTheme.headline3)
                                  : TextSpan(
                                      text: (item.split('\n'))[i] + '\n',
                                      style: terminalTheme.textTheme.headline2),
                            ],
                            (item.split('\n'))[i] == promt
                                ? TextSpan(
                                    text: (item.split('\n'))[i] + ' ',
                                    style: terminalTheme.textTheme.headline3,
                                  )
                                : TextSpan(
                                    text: (item.split('\n'))[i] + ' ',
                                    style: terminalTheme.textTheme.headline3,
                                  ),
                          ]
                        ]),
                      ),
                    ),
                  ),
            Row(
              children: [
                Text(
                  promt + ' ',
                  style: terminalTheme.textTheme.headline3,
                ),
                Expanded(
                  child: TextField(
                    decoration: null,
                    controller: textcontroller,
                    style: terminalTheme.textTheme.headline2,
                    onSubmitted: (txt) {
                      setState(
                        () {
                          if (txt == 'clear')
                            text = '';
                          else {
                            String t = Terminal(cmd: txt).printCmd();
                            text += text.length == 0 ? '' : '\n';
                            text += promt + ' ' + txt + '\n' + t;
                          }
                          for (item in text.split(" ")) {
                            print(item);
                            String x;
                            for (x in item.split('\n')) {
                              if (x == promt) print("Yes");
                            }
                            //if (item == promt) print('YES+$promt');
                          }
                          textcontroller.text = "";
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
