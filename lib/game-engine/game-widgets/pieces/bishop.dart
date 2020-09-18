import 'package:Chess/game-engine/board-state.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/material.dart';

class Bishop extends Piece {
  final Player player;
  final Key key;

  Bishop({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.Bishop);

  @override
  List<SquareNumber> getAvailableMoves(BoardState boardState) {
    final List<List<int>> bishopMoves = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ];

    SquareNumber currentPosition = getCurrentPosition(boardState);

    return bishopMoves
        .map((move) => exploreInOneDirection(
            currentPosition, boardState, player, move[0], move[1]))
        .expand((element) => element)
        .toList();
  }
}
