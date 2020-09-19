import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      String whoseTurn =
          gameProvider.whoseTurnNow() == gameProvider.getPlayerColor()
              ? "Your"
              : "Their";

      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          "$whoseTurn turn",
          style: TextStyle(fontSize: 20.0),
        ),
      );
    });
  }
}
