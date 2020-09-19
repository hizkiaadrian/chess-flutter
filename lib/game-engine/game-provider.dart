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
import 'package:Chess/dialogs/game-ended-dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  GameProvider() {
    initializeProviderState();
  }

  BoardState _boardState;
  BoardState get boardState => _boardState;

  Player _playerColor;
  Player get playerColor => _playerColor;

  Player _playerTurn;
  Player get playerTurn => _playerTurn;

  Map<Player, List<Piece>> _capturedPieces;
  Map<Player, List<Piece>> get capturedPieces => _capturedPieces;

  Piece _selectedPiece;
  Piece get selectedPiece => _selectedPiece;

  List<SquareNumber> _availableMoves;
  List<SquareNumber> get availableMoves => _availableMoves;

  bool _isCheck;

  void initializeProviderState() => {
        _boardState = BoardState(
            piecePosition: generateStartingBoard(), movesHistory: List<Move>()),
        _playerColor = Player.White,
        _playerTurn = Player.White,
        _capturedPieces = {Player.White: [], Player.Black: []},
        _selectedPiece = null,
        _availableMoves = [],
        _isCheck = false,
        notifyListeners()
      };

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

  bool isChecked() => _isCheck;

  void setPlayerColor(Player player) => {
        _playerColor = player,
        notifyListeners(),
      };

  void selectPiece(Piece piece) => {
        _selectedPiece = piece,
        _availableMoves = _selectedPiece == null
            ? []
            : _selectedPiece.getAvailableMovesWithoutExposingCheck(_boardState),
        notifyListeners(),
      };

  void movePiece(SquareNumber destination) async {
    _isCheck = false;

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

    selectPiece(null);

    if (determineIfCheck(_boardState, _playerTurn.getOpponent())) {
      _isCheck = true;
    }
    if (determineIfCheckmate(_boardState, _playerTurn.getOpponent())) {
      await showDialog(
          context: navigatorKey.currentState.overlay.context,
          builder: (_) => GameEndedDialog(
                winner: _playerTurn,
                isCheck: _isCheck,
              ));
    } else {
      _playerTurn = _playerTurn.getOpponent();
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
}

extension ListCleaner on List {
  void removeAll() => removeWhere((_) => true);
}
