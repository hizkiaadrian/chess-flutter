import 'package:Chess/utils/board.dart';
import 'package:Chess/utils/tile.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Player 2"),
                ChessBoard(),
                Text("Player 1"),
              ],
            ),
          ),
          FloatingActionButton(
            child: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
