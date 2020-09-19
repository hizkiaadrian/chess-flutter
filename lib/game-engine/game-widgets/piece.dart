import 'package:Chess/game-engine/board-state.dart';
import 'package:Chess/game-engine/check-checker.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/utils/image.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Piece extends StatelessWidget {
  final Key key;
  final Player player;
  final PieceName pieceName;

  Piece({this.player, this.key, this.pieceName});

  List<SquareNumber> getValidMoves(BoardState boardState);

  SquareNumber getCurrentPosition(BoardState boardState) =>
      boardState.piecePosition.keys.firstWhere(
        (key) => boardState.piecePosition[key] == this,
        orElse: () => null,
      );

  bool pieceWillBeCaptured(GameProvider gameProvider) =>
      gameProvider.playerTurn == player.getOpponent() &&
      gameProvider.availableMoves
          .contains(getCurrentPosition(gameProvider.boardState));

  bool pieceCanBeMoved(GameProvider gameProvider) =>
      gameProvider.playerTurn == player &&
      gameProvider.playerTurn == gameProvider.playerColor;

  List<SquareNumber> getAvailableMovesWithoutExposingCheck(
      BoardState boardState) {
    return getValidMoves(boardState)
        .where((move) =>
            !determineIfCheck(simulateMove(boardState, this, move), player))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
        builder: (context, gameProvider, child) => GestureDetector(
            onTap: () {
              if (pieceWillBeCaptured(gameProvider)) {
                gameProvider
                    .movePiece(getCurrentPosition(gameProvider.boardState));
              } else if (pieceCanBeMoved(gameProvider)) {
                gameProvider.selectPiece(
                    gameProvider.selectedPiece == this ? null : this);
              }
            },
            child: getSprite(player, pieceName)));
  }
}
