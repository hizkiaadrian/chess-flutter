import 'package:Chess/constants/routes.dart';
import 'package:Chess/dialogs/choose-player.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameEndedDialog extends StatelessWidget {
  final Player winner;
  final bool isCheck;

  GameEndedDialog({this.winner, this.isCheck});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      String dialogContent = isCheck
          ? "${winner.asString()} wins"
          : "The game ended in a stalemate";
      return AlertDialog(
        title: Text(isCheck ? "Checkmate" : "Stalemate"),
        content: Text(dialogContent),
        actions: [
          FlatButton(
            child: Text("Play Again"),
            onPressed: () => {
              gameProvider.initializeProviderState(),
              showDialog(
                  context: context,
                  builder: (_) => ChoosePlayerDialog(),
                  barrierDismissible: false)
            },
          ),
          FlatButton(
            child: Text("Home"),
            onPressed: () => {
              gameProvider.initializeProviderState(),
              Navigator.pushReplacementNamed(context, Routes.Home)
            },
          )
        ],
      );
    });
  }
}
