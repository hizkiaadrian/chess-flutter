import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

class Bishop extends Piece {
  final Player player;
  final Key key;

  Bishop({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.Bishop);

  @override
  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState) {
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
