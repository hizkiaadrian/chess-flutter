import 'package:Chess/game-engine/provider/typedefs/board-state.dart';
import 'package:Chess/game-engine/provider/handlers/check-handler.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
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

  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState);

  SquareNumber getCurrentPosition(BoardState boardState) =>
      boardState.piecePosition.keys.firstWhere(
        (key) => boardState.piecePosition[key] == this,
        orElse: () => null,
      );

  bool pieceWillBeCaptured(GameProvider gameProvider) =>
      gameProvider.whoseTurnNow() == player.getOpponent() &&
      gameProvider
          .getAvailableMoves()
          .contains(getCurrentPosition(gameProvider.getBoardState()));

  bool pieceCanBeMoved(GameProvider gameProvider) =>
      gameProvider.whoseTurnNow() == player && !gameProvider.shouldBotMove();

  List<SquareNumber> getLegalMovesPostCheckHandler(BoardState boardState) {
    return getLegalMovesPreCheckHandler(boardState)
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
                gameProvider.movePiece(
                    getCurrentPosition(gameProvider.getBoardState()));
              } else if (pieceCanBeMoved(gameProvider)) {
                gameProvider.selectPiece(
                    gameProvider.getSelectedPiece() == this ? null : this);
              }
            },
            child: getSprite(player, pieceName)));
  }
}
