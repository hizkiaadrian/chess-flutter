import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

class Rook extends Piece {
  final Player player;
  final Key key;

  Rook({this.key, this.player})
      : super(key: key, player: player, pieceName: PieceName.Rook);

  @override
  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState) {
    const rookMoves = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1]
    ];

    SquareNumber currentPosition = getCurrentPosition(boardState);

    return rookMoves
        .map((move) => exploreInOneDirection(
            currentPosition, boardState, player, move[0], move[1]))
        .expand((element) => element)
        .toList();
  }
}
