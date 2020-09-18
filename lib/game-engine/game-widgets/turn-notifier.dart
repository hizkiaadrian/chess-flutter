import 'package:Chess/game-engine/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Chess/game-engine/utils/player.dart';

class TurnNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Text(
          "Player ${gameProvider.playerTurn.asString()}'s turn",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
