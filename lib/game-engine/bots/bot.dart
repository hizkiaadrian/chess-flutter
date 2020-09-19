import 'package:Chess/game-engine/board-state.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/move.dart';
import 'package:Chess/game-engine/utils/square.dart';
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
            gameProvider.selectedPiece = moveToMake.piece;
            gameProvider.movePiece(moveToMake.destination);
          }
        });
        return Container();
      },
    );
  }
}

class RandomBot extends Bot {
  Move makeMove(BoardState boardState, Player botColor) {
    Iterable<Piece> ownPieces = boardState.piecePosition.values
        .where((piece) => piece?.player == botColor);
    Piece piecetoMove = (ownPieces
            .where((piece) => piece
                .getAvailableMovesWithoutExposingCheck(boardState)
                .isNotEmpty)
            .toList()
              ..shuffle())
        .first;
    SquareNumber destination =
        (piecetoMove.getAvailableMovesWithoutExposingCheck(boardState)
              ..shuffle())
            .first;
    return Move(piece: piecetoMove, destination: destination);
  }
}
