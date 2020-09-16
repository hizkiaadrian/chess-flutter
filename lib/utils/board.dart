import 'package:Chess/utils/tile.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatefulWidget {
  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: GridView.count(
        crossAxisCount: 8,
        children: generateTiles(),
      ),
    );
  }
}

List<Widget> generateTiles() {
  final List<int> tileNumbers = List<int>.generate(64, (index) => index + 1);

  List<Widget> tiles = [];
  for (int number in tileNumbers) {
    String row = String.fromCharCode((number - 1) % 8 + 65);
    String col = (8 - ((number - (number - 1) % 8) / 8).round()).toString();
    tiles.add(Tile(
      key: UniqueKey(),
      tileName: "$row$col",
    ));
  }
  return tiles;
}
