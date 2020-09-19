import 'package:Chess/game-engine/board-state.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/material.dart';

class Pawn extends Piece {
  final Player player;
  final Key key;

  Pawn({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.Pawn);

  @override
  List<SquareNumber> getValidMoves(BoardState boardState) {
    SquareNumber currentPosition = getCurrentPosition(boardState);

    return [
      !boardState.movesHistory.any((element) => element.piece == this) &&
              checkForwardMoveAvailable(currentPosition, boardState, 2)
          ? currentPosition.getSquareInDirection(determineRowOrientation(2), 0)
          : null,
      checkForwardMoveAvailable(currentPosition, boardState, 1)
          ? currentPosition.getSquareInDirection(determineRowOrientation(1), 0)
          : null,
      checkDiagonalMoveAvailable(currentPosition, boardState, 1, 1) ||
              checkEnPassantAvailable(currentPosition, boardState, 1)
          ? currentPosition.getSquareInDirection(determineRowOrientation(1), 1)
          : null,
      checkDiagonalMoveAvailable(currentPosition, boardState, 1, -1) ||
              checkEnPassantAvailable(currentPosition, boardState, -1)
          ? currentPosition.getSquareInDirection(determineRowOrientation(1), -1)
          : null,
    ].where((e) => e != null).toList();
  }

  int determineRowOrientation(int multiplier) =>
      player == Player.White ? multiplier : -multiplier;

  bool checkForwardMoveAvailable(
      SquareNumber currentPosition, BoardState boardState, int direction) {
    List<int> directionEnum =
        List<int>.generate(direction, (index) => index + 1);
    return directionEnum.every((rowDirection) =>
        currentPosition.getSquareInDirection(
                determineRowOrientation(rowDirection), 0) !=
            null &&
        boardState.piecePosition[currentPosition.getSquareInDirection(
                determineRowOrientation(rowDirection), 0)] ==
            null);
  }

  bool checkDiagonalMoveAvailable(SquareNumber currentPosition,
      BoardState boardState, int rowDirection, int colDirection) {
    return currentPosition.getSquareInDirection(
                determineRowOrientation(rowDirection), colDirection) !=
            null &&
        boardState
                .piecePosition[currentPosition.getSquareInDirection(
                    determineRowOrientation(rowDirection), colDirection)]
                ?.player ==
            player.getOpponent();
  }

  bool checkEnPassantAvailable(
      SquareNumber currentPosition, BoardState boardState, int colDirection) {
    bool checkSelfRow =
        currentPosition.getRowNumber() == (player == Player.White ? 5 : 4);

    bool checkLastMove = boardState.movesHistory.isNotEmpty &&
        boardState.movesHistory.last.destination ==
            currentPosition.getSquareInDirection(0, colDirection) &&
        boardState.movesHistory.last.piece.pieceName == PieceName.Pawn &&
        boardState.movesHistory
                .where((moveHistory) =>
                    moveHistory.piece == boardState.movesHistory.last.piece)
                .length ==
            1;

    return checkSelfRow && checkLastMove;
  }
}
