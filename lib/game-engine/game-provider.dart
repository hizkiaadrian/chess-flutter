import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/bots/bot.dart';
import 'package:Chess/game-engine/bots/random-bot.dart';
import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/game-engine/handlers/check-handler.dart';
import 'package:Chess/game-engine/initial-boardstate.dart';
import 'package:Chess/game-engine/typedefs/game-mode.dart';
import 'package:Chess/game-engine/typedefs/move.dart';
import 'package:Chess/game-engine/handlers/pawn-promotion-handler.dart';
import 'package:Chess/utils/piece.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  GameProvider() {
    initializeProviderState();

    _expectBotMove.addListener(() {
      if (_expectBotMove.value) {
        Move botMove = _bot.makeMove(_boardState, _playerColor.getOpponent());
        selectPiece(botMove.piece);
        movePiece(botMove.destination);
      }
    });
  }

  GameMode _gameMode;
  BoardState _boardState;
  Player _playerColor;
  Player _playerTurn;
  Map<Player, List<Piece>> _capturedPieces;
  Piece _selectedPiece;
  List<SquareNumber> _availableMoves;
  bool _isCheck;
  ValueNotifier _expectBotMove = ValueNotifier(false);
  Bot _bot;

  BoardState _prevBoardState; //For undoing
  Map<Player, List<Piece>> _prevCapturedPieces;

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
  bool shouldBotMove() => _expectBotMove.value;

  BoardState getPreviousBoardState() => _prevBoardState;

  /* ************************************************************************ */
  /* Initializers */
  void initializeProviderState() => {
        _boardState = BoardState(
            piecePosition: generateStartingBoard(), movesHistory: List<Move>()),
        _prevBoardState = null,
        _playerColor = Player.White,
        _playerTurn = Player.White,
        _capturedPieces = {Player.White: [], Player.Black: []},
        _selectedPiece = null,
        _availableMoves = [],
        _isCheck = false,
        _expectBotMove.value = false,
        notifyListeners()
      };

  void setGameMode(GameMode gameMode) => {
        _gameMode = gameMode,
        _bot = _gameMode == GameMode.AgainstBot ? RandomBot() : null
      };

  void setPlayerColorAndStartGame(Player player, BuildContext context) => {
        _playerColor = player,
        _expectBotMove.value =
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
    if (_gameMode == GameMode.AgainstBot && _playerTurn == _playerColor) {
      _storePreviousBoardState();
    }

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
      _expectBotMove.value =
          _gameMode == GameMode.AgainstBot && _playerTurn != _playerColor;
    }

    notifyListeners();
  }

  void _changePiecePosition(
      Piece piece, SquareNumber prevSquare, SquareNumber destination) {
    _boardState.piecePosition[prevSquare] = null;
    _boardState.piecePosition[destination] = piece;
  }

  void _storePreviousBoardState() => {
        _prevBoardState = BoardState(
          piecePosition:
              Map<SquareNumber, Piece>.from(_boardState.piecePosition),
          movesHistory: List<Move>.from(_boardState.movesHistory),
        ),
        _prevCapturedPieces = {
          Player.White: List<Piece>.from(_capturedPieces[Player.White]),
          Player.Black: List<Piece>.from(_capturedPieces[Player.Black]),
        }
      };

  void undoMove() => {
        _boardState = BoardState(
          piecePosition:
              Map<SquareNumber, Piece>.from(_prevBoardState.piecePosition),
          movesHistory: List<Move>.from(_prevBoardState.movesHistory),
        ),
        _prevBoardState = null,
        _capturedPieces = {
          Player.White: List<Piece>.from(_prevCapturedPieces[Player.White]),
          Player.Black: List<Piece>.from(_prevCapturedPieces[Player.Black]),
        },
        _prevCapturedPieces = null,
        notifyListeners()
      };
  /* ************************************************************************ */
  /* Move side effects */
  void _handleMoveSideEffect(
      SquareNumber prevSquare, SquareNumber destination) {
    if (_boardState.piecePosition[destination] != null) {
      _onPieceCaptured(_boardState.piecePosition[destination]);
    } else {
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
      if (_gameMode == GameMode.AgainstBot &&
          _selectedPiece.player != _playerColor) {
        _boardState.piecePosition[destination] = _bot.choosePieceForPromotion(
            _boardState, _playerColor.getOpponent());
      } else {
        _boardState.piecePosition[destination] =
            await choosePieceForPromotion(_selectedPiece.player);
      }
    }
  }
}
