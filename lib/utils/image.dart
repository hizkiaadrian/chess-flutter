import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:flutter/material.dart';

Image getSprite(Player player, PieceName pieceName) {
  return Image.asset(
    'assets/${player.asString().toLowerCase()}_${pieceName.asString().toLowerCase()}.png',
  );
}
