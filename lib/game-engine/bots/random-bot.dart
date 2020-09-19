import 'package:Chess/screens/game-widgets/pieces/queen.dart';
import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/game-engine/bots/bot.dart';
import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/game-engine/typedefs/move.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

class RandomBot extends Bot {
  Move makeMove(BoardState boardState, Player botColor) {
    Iterable<Piece> ownPieces = boardState.piecePosition.values
        .where((piece) => piece?.player == botColor);
    Piece piecetoMove = (ownPieces
            .where((piece) =>
                piece.getLegalMovesPostCheckHandler(boardState).isNotEmpty)
            .toList()
              ..shuffle())
        .first;
    SquareNumber destination =
        (piecetoMove.getLegalMovesPostCheckHandler(boardState)..shuffle())
            .first;
    return Move(piece: piecetoMove, destination: destination);
  }

  @override
  Piece choosePieceForPromotion(BoardState boardState, Player botColor) {
    return Queen(
      player: botColor,
      key: UniqueKey(),
    );
  }
}
