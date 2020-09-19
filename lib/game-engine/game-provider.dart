import 'package:Chess/game-engine/board-state.dart';
import 'package:Chess/game-engine/check-checker.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/constants/initial-boardstate.dart';
import 'package:Chess/game-engine/move.dart';
import 'package:Chess/game-engine/pawn-promotion.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:Chess/main.dart';
import 'package:Chess/dialogs/checkmate-dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  BoardState _boardState = BoardState(
      piecePosition: generateStartingBoard(), movesHistory: List<Move>());
  BoardState get boardState => _boardState;

  Player _playerColor = Player.White;
  Player get playerColor => _playerColor;
  set playerColor(Player player) => {
        _playerColor = player,
        notifyListeners(),
      };

  Player _playerTurn = Player.White;
  Player get playerTurn => _playerTurn;
  set playerTurn(Player player) => {
        _playerTurn = player,
        notifyListeners(),
      };

  Map<Player, List<Piece>> _capturedPieces = {
    Player.White: [],
    Player.Black: []
  };
  Map<Player, List<Piece>> get capturedPieces => _capturedPieces;

  Piece _selectedPiece;
  Piece get selectedPiece => _selectedPiece;
  set selectedPiece(Piece piece) => {
        _selectedPiece = piece,
        availableMoves = _selectedPiece == null
            ? []
            : _selectedPiece.getAvailableMovesWithoutExposingCheck(_boardState),
      };

  List<SquareNumber> _availableMoves = [];
  List<SquareNumber> get availableMoves => _availableMoves;
  set availableMoves(List<SquareNumber> moves) => {
        _availableMoves = moves,
        notifyListeners(),
      };

  bool _isCheck = false;
  bool get isCheck => _isCheck;
  set isCheck(bool check) => {
        _isCheck = check,
        notifyListeners(),
      };

  void movePiece(SquareNumber destination) async {
    isCheck = false;

    SquareNumber prevSquare = _selectedPiece.getCurrentPosition(_boardState);

    _boardState.piecePosition[prevSquare] = null;

    if (_boardState.piecePosition[destination] != null) {
      capturePiece(_boardState.piecePosition[destination]);
    } else {
      // In both en passant and castling, destination square must be empty
      capturePieceIfEnPassant(prevSquare, destination);
      moveRookIfCastling(destination, prevSquare);
    }

    _boardState.piecePosition[destination] = _selectedPiece;

    if (_selectedPiece.pieceName == PieceName.Pawn &&
        destination.getRowNumber() ==
            (_selectedPiece.player == Player.White ? 8 : 1)) {
      _boardState.piecePosition[destination] =
          await choosePieceForPromotion(_selectedPiece.player);
    }

    _boardState.movesHistory
        .add(Move(piece: selectedPiece, destination: destination));

    selectedPiece = null;

    playerTurn = playerTurn.getOpponent();
    if (determineIfCheck(_boardState, _playerTurn)) {
      isCheck = true;
    }
    if (determineIfCheckmate(_boardState, _playerTurn)) {
      await showDialog(
          context: navigatorKey.currentState.overlay.context,
          builder: (_) => CheckmateDialog(
                player: _playerTurn.getOpponent(),
                isCheck: _isCheck,
              ));
    }

    notifyListeners();
  }

  void capturePiece(Piece piece) {
    _capturedPieces[piece.player].add(piece);
    _boardState.piecePosition[piece.getCurrentPosition(_boardState)] = null;
  }

  void capturePieceIfEnPassant(
      SquareNumber prevSquare, SquareNumber destination) {
    /* To accomplish en passant,
      1. the moving piece must be a pawn
      2. the piece must be on the right row (5 for white, 4 for black)
      3. the destination must be forward diagonal */
    if (_selectedPiece.pieceName == PieceName.Pawn &&
        prevSquare.getRowNumber() ==
            (_selectedPiece.player == Player.White ? 5 : 4)) {
      if (prevSquare.getSquareInDirection(
              _selectedPiece.player == Player.White ? 1 : -1, 1) ==
          destination) {
        capturePiece(
            _boardState.piecePosition[prevSquare.getSquareInDirection(0, 1)]);
      } else if (prevSquare.getSquareInDirection(
              _selectedPiece.player == Player.White ? 1 : -1, -1) ==
          destination) {
        capturePiece(
            _boardState.piecePosition[prevSquare.getSquareInDirection(0, -1)]);
      }
    }
  }

  void moveRookIfCastling(SquareNumber destination, SquareNumber prevSquare) {
    /* To accomplish castling,
      1. the moving piece must be a king
      2. the destination distance must be greater than 1 */
    if (_selectedPiece.pieceName == PieceName.King &&
        (destination.getColLetter().codeUnitAt(0) -
                    prevSquare.getColLetter().codeUnitAt(0))
                .abs() >
            1) {
      SquareNumber rookPrevSquare = destination.getSquareInDirection(
          0, destination.getColLetter() == 'G' ? 1 : -1);
      SquareNumber rookDestination = destination.getSquareInDirection(
          0, destination.getColLetter() == 'G' ? -1 : 1);

      Piece rook = _boardState.piecePosition[rookPrevSquare];
      _boardState.piecePosition[rookPrevSquare] = null;
      _boardState.piecePosition[rookDestination] = rook;
    }
  }

  void restartGame() => {
        _boardState.piecePosition = generateStartingBoard(),
        _boardState.movesHistory.removeAll(),
        _playerColor = Player.White,
        _playerTurn = Player.White,
        _capturedPieces.values.forEach((list) => list.removeAll()),
        _selectedPiece = null,
        _availableMoves.removeAll(),
        _isCheck = false,
        notifyListeners(),
      };
}

extension ListCleaner on List {
  void removeAll() => removeWhere((_) => true);
}
