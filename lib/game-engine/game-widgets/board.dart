import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/game-widgets/captured-pieces.dart';
import 'package:Chess/game-engine/game-widgets/square.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChessBoard extends StatelessWidget {
  final List<int> rows = List<int>.generate(8, (index) => 8 - index);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, gameProvider, child) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CapturedPieces(player: Player.Black),
        ...renderBoard(gameProvider.playerColor),
        CapturedPieces(player: Player.White),
      ]);
    });
  }
}

List<Row> renderBoard(Player player) {
  final List<int> rows = List<int>.generate(
      8, (index) => player == Player.White ? (8 - index) : (index + 1));

  return rows.map((rowNumber) => generateRow(player, rowNumber)).toList();
}

Row generateRow(Player player, int rowNumber) {
  List<Square> squares = SquareNumber.values
      .where((square) => square.getRowNumber() == rowNumber)
      .map((square) => Square(square: square))
      .toList();
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: player == Player.White ? squares : squares.reversed.toList());
}
