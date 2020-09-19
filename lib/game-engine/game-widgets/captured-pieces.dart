import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/utils/image.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CapturedPieces extends StatelessWidget {
  final Player player;
  CapturedPieces({this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Consumer<GameProvider>(
        builder: (context, gameProvider, child) => LimitedBox(
          maxHeight: 70.0,
          child: GridView.count(
              crossAxisCount: 10,
              children: gameProvider
                  .getCapturedPieces()[player]
                  .map((e) => getSprite(player, e.pieceName))
                  .toList()),
        ),
      ),
    );
  }
}
