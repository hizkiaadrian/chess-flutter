import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

import '../piece.dart';

class King extends Piece {
  final Player player;
  final Key key;

  King({this.player, this.key})
      : super(key: key, player: player, pieceName: PieceName.King);

  @override
  List<SquareNumber> getLegalMovesPreCheckHandler(BoardState boardState) {
    final List<List<int>> kingMoves = [
      [1, 0],
      [1, -1],
      [1, 1],
      [0, 1],
      [0, -1],
      [-1, 0],
      [-1, 1],
      [-1, -1]
    ];

    SquareNumber currentPosition = getCurrentPosition(boardState);

    return [
      ...kingMoves.map((move) {
        SquareNumber squareToExplore =
            currentPosition.getSquareInDirection(move[0], move[1]);
        if (squareToExplore != null &&
            boardState.piecePosition[squareToExplore]?.player != player) {
          return squareToExplore;
        }
      }).toList(),
      ...getCastlingMoves(boardState, currentPosition)
    ].where((element) => element != null).toList();
  }

  List<SquareNumber> getCastlingMoves(
      BoardState boardState, SquareNumber kingPosition) {
    Iterable<Piece> rooksOnBoardThatHasNotMoved =
        boardState.piecePosition.values.where((piece) =>
            piece?.player == player &&
            piece?.pieceName == PieceName.Rook &&
            !boardState.movesHistory.any((move) => move.piece == piece));

    return boardState.movesHistory.any((move) => move.piece == this)
        ? []
        : rooksOnBoardThatHasNotMoved.map((rook) {
            SquareNumber rookPosition = rook.getCurrentPosition(boardState);

            if (checkIfClearPathBetweenKingAndRook(
                boardState, kingPosition, rookPosition)) {
              return rookPosition.getSquareInDirection(
                  0,
                  rookPosition.getColLetter().codeUnitAt(0) >
                          kingPosition.getColLetter().codeUnitAt(0)
                      ? -1
                      : 1);
            }
          }).toList();
  }

  bool checkIfClearPathBetweenKingAndRook(BoardState boardState,
      SquareNumber kingPosition, SquareNumber rookPosition) {
    int numberOfSquaresBetweenKingAndRook =
        (rookPosition.getColLetter().codeUnitAt(0) -
                    kingPosition.getColLetter().codeUnitAt(0))
                .abs() -
            1;
    int iteratorMultiplier = rookPosition.getColLetter().codeUnitAt(0) >
            kingPosition.getColLetter().codeUnitAt(0)
        ? 1
        : -1;
    return List<SquareNumber>.generate(
        numberOfSquaresBetweenKingAndRook,
        (index) => kingPosition.getSquareInDirection(
            0, iteratorMultiplier * (index + 1))).every((square) {
      return boardState.piecePosition[square] == null;
    });
  }
}
