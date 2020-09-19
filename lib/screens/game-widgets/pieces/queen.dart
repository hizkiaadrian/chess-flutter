import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

class Queen extends Piece {
  final Key key;
  final Player player;

  Queen({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.Queen);

  @override
  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState) {
    const queenMoves = [
      [1, 0],
      [1, -1],
      [1, 1],
      [0, 1],
      [0, -1],
      [-1, 0],
      [-1, 1],
      [-1, -1]
    ];

    SquareNumber currentPosition = getCurrentPosition(boardState);

    return queenMoves
        .map((move) => exploreInOneDirection(
            currentPosition, boardState, player, move[0], move[1]))
        .expand((element) => element)
        .toList();
  }
}
