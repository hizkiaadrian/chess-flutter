import 'package:Chess/constants/config.dart';
import 'package:Chess/screens/game-widgets/board.dart';
import 'package:Chess/screens/game-widgets/check-notifier.dart';
import 'package:Chess/screens/game-widgets/turn-notifier.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ChessBoard()),
            CheckNotifier(),
            TurnNotifier(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.settings,
        ),
        onPressed: () => print("Settings"),
      ),
    );
  }
}
