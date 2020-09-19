import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/provider/typedefs/board-state.dart';
import 'package:Chess/game-engine/provider/handlers/check-handler.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/constants/initial-boardstate.dart';
import 'package:Chess/game-engine/provider/typedefs/game-mode.dart';
import 'package:Chess/game-engine/provider/typedefs/move.dart';
import 'package:Chess/game-engine/provider/handlers/pawn-promotion-handler.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:Chess/game-engine/utils/square.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  GameProvider() {
    initializeProviderState();
  }

  GameMode _gameMode;
  BoardState _boardState;
  Player _playerColor;
  Player _playerTurn;
  Map<Player, List<Piece>> _capturedPieces;
  Piece _selectedPiece;
  List<SquareNumber> _availableMoves;
  bool _isCheck;
  bool _expectBotMove;

  /* Getters */
  GameMode getGameMode() => _gameMode;
  BoardState getBoardState() => _boardState;
  Map<SquareNumber, Piece> getPiecePositions() => _boardState.piecePosition;
  List<Move> getMovesHistory() => _boardState.movesHistory;
  Player getPlayerColor() => _playerColor;
  Player whoseTurnNow() => _playerTurn;
  Map<Player, List<Piece>> getCapturedPieces() => _capturedPieces;
  Piece getSelectedPiece() => _selectedPiece;
  List<SquareNumber> getAvailableMoves() => _availableMoves;
  bool isChecked() => _isCheck;
  bool shouldBotMove() => _expectBotMove;

  /* ************************************************************************ */
  /* Initializers */
  void initializeProviderState() => {
        _gameMode = GameMode.AgainstBot,
        _boardState = BoardState(
            piecePosition: generateStartingBoard(), movesHistory: List<Move>()),
        _playerColor = Player.White,
        _playerTurn = Player.White,
        _capturedPieces = {Player.White: [], Player.Black: []},
        _selectedPiece = null,
        _availableMoves = [],
        _isCheck = false,
        _expectBotMove = false,
        notifyListeners()
      };

  void setGameMode(GameMode gameMode) => _gameMode = gameMode;

  void setPlayerColorAndStartGame(Player player, BuildContext context) => {
        _playerColor = player,
        _expectBotMove =
            _gameMode == GameMode.AgainstBot && player == Player.Black,
        Navigator.pushReplacementNamed(context, Routes.Game),
        notifyListeners(),
      };

  /* ************************************************************************ */
  /* Piece Selection and Deselection */
  void selectPiece(Piece piece) => {
        _selectedPiece = piece,
        _availableMoves = _selectedPiece == null
            ? []
            : _selectedPiece.getLegalMovesPostCheckHandler(_boardState),
        notifyListeners(),
      };

  void deselectPiece() => selectPiece(null);

  /* ************************************************************************ */
  /* Piece movement */
  void movePiece(SquareNumber destination) async {
    _isCheck = false;

    SquareNumber prevSquare = _selectedPiece.getCurrentPosition(_boardState);

    // Side effects refer to: on piece captured, on En Passant, and Castling
    _handleMoveSideEffect(prevSquare, destination);
    _changePiecePosition(_selectedPiece, prevSquare, destination);

    await _onPawnPromotion(destination);

    _boardState.movesHistory
        .add(Move(piece: _selectedPiece, destination: destination));

    deselectPiece();

    if (determineIfCheck(_boardState, _playerTurn.getOpponent())) {
      _isCheck = true;
    }
    if (determineIfCheckmate(_boardState, _playerTurn.getOpponent())) {
      await showEndGameDialog(_playerTurn, _isCheck);
    } else {
      _playerTurn = _playerTurn.getOpponent();
      _expectBotMove =
          _gameMode == GameMode.AgainstBot && _playerTurn != _playerColor;
    }

    notifyListeners();
  }

  void _changePiecePosition(
      Piece piece, SquareNumber prevSquare, SquareNumber destination) {
    _boardState.piecePosition[prevSquare] = null;
    _boardState.piecePosition[destination] = piece;
  }

  /* ************************************************************************ */
  /* Move side effects */
  void _handleMoveSideEffect(
      SquareNumber prevSquare, SquareNumber destination) {
    if (_boardState.piecePosition[destination] != null) {
      _onPieceCaptured(_boardState.piecePosition[destination]);
    } else {
      // In both en passant and castling, destination square must be empty
      _onEnPassant(prevSquare, destination);
      _onCastling(destination, prevSquare);
    }
  }

  void _onPieceCaptured(Piece pieceToCapture) {
    _capturedPieces[pieceToCapture.player].add(pieceToCapture);
    _boardState.piecePosition[pieceToCapture.getCurrentPosition(_boardState)] =
        null;
  }

  void _onEnPassant(SquareNumber prevSquare, SquareNumber destination) {
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
        _onPieceCaptured(
            _boardState.piecePosition[prevSquare.getSquareInDirection(0, 1)]);
      } else if (prevSquare.getSquareInDirection(
              _selectedPiece.player == Player.White ? 1 : -1, -1) ==
          destination) {
        _onPieceCaptured(
            _boardState.piecePosition[prevSquare.getSquareInDirection(0, -1)]);
      }
    }
  }

  void _onCastling(SquareNumber destination, SquareNumber prevSquare) {
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
      _changePiecePosition(rook, rookPrevSquare, rookDestination);
    }
  }

  Future _onPawnPromotion(SquareNumber destination) async {
    if (_selectedPiece.pieceName == PieceName.Pawn &&
        destination.getRowNumber() ==
            (_selectedPiece.player == Player.White ? 8 : 1)) {
      _boardState.piecePosition[destination] =
          await choosePieceForPromotion(_selectedPiece.player);
    }
  }
}

extension ListCleaner on List {
  void removeAll() => removeWhere((_) => true);
}
