import 'package:Chess/game-engine/game-widgets/captured-pieces.dart';
import 'package:Chess/game-engine/game-widgets/square.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  final List<int> rows = List<int>.generate(8, (index) => 8 - index);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CapturedPieces(
        player: Player.Black,
      ),
      ...rows.map((rowNumber) => generateRow(rowNumber)).toList(),
      CapturedPieces(
        player: Player.White,
      ),
    ]);
  }
}

Row generateRow(int rowNumber) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: SquareNumber.values
        .where((square) => square.getRowNumber() == rowNumber)
        .map((square) => Square(
              square: square,
            ))
        .toList(),
  );
}
