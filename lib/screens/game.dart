import 'package:Chess/game-engine/game-widgets/board.dart';
import 'package:Chess/game-engine/game-widgets/check-notifier.dart';
import 'package:Chess/game-engine/game-widgets/turn-notifier.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gameView(),
          actionButtons(context),
        ],
      ),
    );
  }
}

Expanded gameView() => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TurnNotifier(),
          ChessBoard(),
          CheckNotifier(),
        ],
      ),
    );

Row actionButtons(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
