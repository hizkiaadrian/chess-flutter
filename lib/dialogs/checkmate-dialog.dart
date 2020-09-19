import 'package:Chess/constants/routes.dart';
import 'package:Chess/dialogs/choose-player.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckmateDialog extends StatelessWidget {
  final Player player;
  final bool isCheck;

  CheckmateDialog({this.player, this.isCheck});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => AlertDialog(
        title: Text(isCheck ? "Checkmate" : "Stalemate"),
        content: Text(isCheck ? "${player.asString()} wins" : ""),
        actions: [
          FlatButton(
            child: Text("Play Again"),
            onPressed: () => {
              gameProvider.restartGame(),
              showDialog(
                  context: context,
                  builder: (_) => ChoosePlayerDialog(),
                  barrierDismissible: false)
            },
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
