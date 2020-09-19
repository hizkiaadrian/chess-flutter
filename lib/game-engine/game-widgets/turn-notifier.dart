import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/provider/typedefs/game-mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Chess/game-engine/utils/player.dart';

class TurnNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      String whoseTurnText() {
        switch (gameProvider.getGameMode()) {
          case GameMode.AgainstBot:
            return gameProvider.whoseTurnNow() == gameProvider.getPlayerColor()
                ? "Your turn"
                : "Bot is thinking...";
          case GameMode.TwoPlayers:
            return "${gameProvider.whoseTurnNow().asString()}'s turn";
          default:
            return "";
        }
      }

      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          whoseTurnText(),
          style: TextStyle(fontSize: 20.0),
        ),
      );
    });
  }
}
