import 'package:flutter/material.dart';

const appTitle = "Chess Mobile";
const double squareSize = 40.0;

class ColorPalette {
  final Color whiteSquare;
  final Color blackSquare;
  final Color selectedSquareBorder;
  final Color availableMovesSquareOverlay;

  ColorPalette(
      {this.whiteSquare,
      this.blackSquare,
      this.selectedSquareBorder,
      this.availableMovesSquareOverlay});
}
