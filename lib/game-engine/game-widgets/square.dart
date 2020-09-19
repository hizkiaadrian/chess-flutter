import 'package:Chess/constants/config.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:Chess/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Square extends StatelessWidget {
  final SquareNumber square;
  final Color squareColor;

  Square({this.square}) : squareColor = square.determineColor();

  bool isSquareSelected(GameProvider gameProvider) =>
      gameProvider.getSelectedPiece() != null &&
      gameProvider.getSelectedPiece() ==
          gameProvider.getPiecePositions()[square];

  Border renderBorderIfSelected(GameProvider gameProvider) => Border.all(
        color: isSquareSelected(gameProvider)
            ? palette.selectedSquareBorder
            : Colors.transparent,
        width: 2.5,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => GestureDetector(
        onTap: () => gameProvider.getAvailableMoves().contains(square)
            ? gameProvider.movePiece(square)
            : null,
        child: Stack(
          children: [
            Container(
              height: squareSize,
              width: squareSize,
              decoration: BoxDecoration(
                border: renderBorderIfSelected(gameProvider),
                color: squareColor,
              ),
              child: gameProvider.getPiecePositions()[square] ?? Container(),
            ),
            if (gameProvider.getAvailableMoves().contains(square))
              Container(
                height: squareSize,
                width: squareSize,
                color: palette.availableMovesSquareOverlay,
              ),
          ],
        ),
      ),
    );
  }
}
