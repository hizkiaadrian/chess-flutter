import 'package:flutter/material.dart';

class StartNewGamePrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Start a new game?"),
      content: Text("Your saved game will be deleted if you start a new game"),
      actions: [
        FlatButton(
          child: Text("Start a new game"),
          onPressed: () => Navigator.pop(context, true),
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
