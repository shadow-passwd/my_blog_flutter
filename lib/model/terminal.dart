import 'package:flutter/widgets.dart';

class Terminal {
  String cmd;
  Terminal({@required this.cmd});

  static const List<String> terminalCommands = [
    'help',
    'clear',
    'whoami',
  ];
  String printCmd(){
    if(cmd=='help') {
      String txt="List of useful commands\n";
      int i=0;
      for(i=0;i<terminalCommands.length-1;i++) txt+=terminalCommands[i]+'\n';
      txt+=terminalCommands[i];
      return txt;
    } 
    else if(cmd=='whoami'){
      String txt='Just another Guy';
      return txt;
    }
    else{
      return 'Invalid command entered!!';
    }
  }
}
