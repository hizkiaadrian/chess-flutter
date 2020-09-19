import 'package:Chess/game-engine/provider/typedefs/board-state.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/provider/typedefs/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:Chess/game-engine/utils/player.dart';

abstract class Bot extends StatelessWidget {
  Move makeMove(BoardState boardState, Player botColor);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (gameProvider.playerTurn ==
              gameProvider.playerColor.getOpponent()) {
            Move moveToMake = makeMove(gameProvider.boardState,
                gameProvider.playerColor.getOpponent());
            gameProvider.selectPiece(moveToMake.piece);
            gameProvider.movePiece(moveToMake.destination);
          }
        });
        return Container();
      },
    );
  }
}
