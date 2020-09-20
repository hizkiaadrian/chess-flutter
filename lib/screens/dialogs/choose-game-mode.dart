import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/typedefs/game-mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseGameModeDialog extends StatelessWidget {
  Widget gameModeButton({String displayText, Function func}) => RaisedButton(
      onPressed: func,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Text(
        displayText,
        style: TextStyle(fontSize: 20.0),
      ));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose game mode"),
      content: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            gameModeButton(
                displayText: "Vs AI",
                func: () => {
                      gameProvider.setGameMode(GameMode.AgainstBot),
                      Navigator.pop(context, GameMode.AgainstBot),
                    }),
            gameModeButton(
                displayText: "PvP Zen Mode",
                func: () => {
                      gameProvider.setGameMode(GameMode.TwoPlayersZenMode),
                      Navigator.pop(context, GameMode.TwoPlayersZenMode),
                    }),
            gameModeButton(
                displayText: "PvP Timed Mode",
                func: () => {
                      gameProvider.setGameMode(GameMode.TwoPlayersTimedMode),
                      Navigator.pop(context, GameMode.TwoPlayersTimedMode),
                    }),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
