import 'package:Chess/dialogs/game-ended-dialog.dart';
import 'package:Chess/game-engine/provider/typedefs/board-state.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/provider/typedefs/move.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:Chess/main.dart';
import 'package:flutter/material.dart';

bool determineIfCheck(BoardState boardState, Player player) {
  Iterable<Piece> opponentPieces = boardState.piecePosition.values
      .where((piece) => piece?.player == player.getOpponent());

  SquareNumber kingPosition = boardState.piecePosition.keys.firstWhere((key) =>
      boardState.piecePosition[key]?.player == player &&
      boardState.piecePosition[key]?.pieceName == PieceName.King);
  return opponentPieces.any((opponentPiece) => opponentPiece
      .getLegalMovesPreCheckHandler(boardState)
      .contains(kingPosition));
}

bool determineIfCheckmate(BoardState boardState, Player player) {
  Iterable<Piece> ownPieces =
      boardState.piecePosition.values.where((piece) => piece?.player == player);

  return ownPieces.every(
      (piece) => piece.getLegalMovesPostCheckHandler(boardState).isEmpty);
}

Future showEndGameDialog(Player winner, bool isCheck) async {
  showDialog(
      context: navigatorKey.currentState.overlay.context,
      builder: (_) => GameEndedDialog(
            winner: winner,
            isCheck: isCheck,
          ));
}

BoardState simulateMove(
    BoardState boardState, Piece movingPiece, SquareNumber destination) {
  Map<SquareNumber, Piece> piecePosition =
      new Map<SquareNumber, Piece>.from(boardState.piecePosition);
  SquareNumber prevSquare = movingPiece.getCurrentPosition(boardState);

  piecePosition[prevSquare] = null;
  piecePosition[destination] = movingPiece;

  if (movingPiece.pieceName == PieceName.King &&
      (destination.getColLetter().codeUnitAt(0) -
                  prevSquare.getColLetter().codeUnitAt(0))
              .abs() >
          1) {
    Piece rook = piecePosition[destination.getSquareInDirection(
        0, destination.getColLetter() == 'B' ? -1 : 1)];
    piecePosition[destination.getSquareInDirection(
        0, destination.getColLetter() == 'B' ? -1 : 1)] = null;
    piecePosition[destination.getSquareInDirection(
        0, destination.getColLetter() == 'B' ? 1 : -1)] = rook;
  }
  if (movingPiece.pieceName == PieceName.Pawn &&
      prevSquare.getRowNumber() ==
          (movingPiece.player == Player.White ? 5 : 4)) {
    if (prevSquare.getSquareInDirection(
            movingPiece.player == Player.White ? 1 : -1, 1) ==
        destination) {
      piecePosition[prevSquare.getSquareInDirection(0, 1)] = null;
    } else if (prevSquare.getSquareInDirection(
            movingPiece.player == Player.White ? 1 : -1, -1) ==
        destination) {
      piecePosition[prevSquare.getSquareInDirection(0, 1)] = null;
    }
  }
  return BoardState(
      piecePosition: piecePosition,
      movesHistory: List<Move>.from(boardState.movesHistory));
}
