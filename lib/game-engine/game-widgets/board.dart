import 'package:Chess/game-engine/game-widgets/square.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 360,
      child: renderBoard(),
    );
  }
}

Widget renderBoard() {
  List<int> rows = List<int>.generate(8, (index) => 8 - index);
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows.map((rowNumber) => generateRow(rowNumber)).toList());
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
