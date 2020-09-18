import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';

Image getSprite(Player player, PieceName pieceName) {
  return Image.asset(
    'assets/${player.asString().toLowerCase()}_${pieceName.asString().toLowerCase()}.png',
  );
}
