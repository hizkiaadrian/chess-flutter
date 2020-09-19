import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/provider/typedefs/game-mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseGameModeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose game mode"),
      content: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
                onPressed: () => {
                      gameProvider.setGameMode(GameMode.AgainstBot),
                      Navigator.pop(context, GameMode.AgainstBot),
                    },
                child: Text("Vs AI")),
            FlatButton(
                onPressed: () => {
                      gameProvider.setGameMode(GameMode.TwoPlayers),
                      Navigator.pop(context, GameMode.TwoPlayers),
                    },
                child: Text("2 Players")),
            FlatButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
