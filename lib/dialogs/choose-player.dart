import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoosePlayerDialog extends StatefulWidget {
  @override
  _ChoosePlayerDialogState createState() => _ChoosePlayerDialogState();
}

class _ChoosePlayerDialogState extends State<ChoosePlayerDialog> {
  Player chosenPlayer;

  void setChosenPlayer(Player player) => setState(() => chosenPlayer = player);

  Widget playerChoice(Player player) => Material(
        child: InkWell(
          onTap: () => setChosenPlayer(player),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: player == Player.Black ? Colors.black : Colors.white,
              border: chosenPlayer == player
                  ? Border.all(color: Colors.yellow, width: 3.0)
                  : Border.all(color: Colors.black, width: 1.0),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose your color"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [playerChoice(Player.White), playerChoice(Player.Black)],
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        Consumer<GameProvider>(
          builder: (context, gameProvider, child) => FlatButton(
              onPressed: () => {
                    gameProvider.setPlayerColor(chosenPlayer),
                    Navigator.pushReplacementNamed(context, Routes.Game)
                  },
              child: Text("Submit")),
        )
      ],
    );
  }
}
