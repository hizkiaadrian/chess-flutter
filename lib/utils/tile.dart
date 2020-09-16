import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String tileName;
  Color tileColor;

  Tile({Key key, this.tileName}) : super(key: key) {
    tileColor = (tileName.codeUnitAt(0) + int.parse(tileName[1])) % 2 == 0
        ? Colors.brown
        : Colors.brown[300];
  }

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      width: 30.0,
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.tileColor),
        child: Center(
            child: Text(
          widget.tileName,
        )),
      ),
    );
  }
}
