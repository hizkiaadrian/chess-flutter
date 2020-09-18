import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckmateDialog extends StatelessWidget {
  final Player player;

  CheckmateDialog({this.player});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => AlertDialog(
        title: Text("Checkmate"),
        content: Text("${player.asString()} wins"),
        actions: [
          FlatButton(
            child: Text("Play Again"),
            onPressed: () =>
                {gameProvider.restartGame(), Navigator.pop(context)},
          ),
          FlatButton(
            child: Text("Home"),
            onPressed: () => {
              gameProvider.restartGame(),
              Navigator.pushReplacementNamed(context, Routes.Home)
            },
          )
        ],
      ),
    );
  }
}
