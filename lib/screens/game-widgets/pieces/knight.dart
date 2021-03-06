import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

import '../piece.dart';

class Knight extends Piece {
  final Player player;
  final Key key;

  Knight({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.Knight);

  @override
  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState) {
    final List<List<int>> knightMoves = [
      [-2, 1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1]
    ];

    SquareNumber currentPosition = getCurrentPosition(boardState);

    return knightMoves
        .map((move) {
          SquareNumber squareToExplore =
              currentPosition.getSquareInDirection(move[0], move[1]);
          if (squareToExplore != null &&
              boardState.piecePosition[squareToExplore]?.player != player) {
            return squareToExplore;
          }
        })
        .where((e) => e != null)
        .toList();
  }
}
