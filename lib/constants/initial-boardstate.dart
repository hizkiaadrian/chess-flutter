import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/screens/game-widgets/pieces/bishop.dart';
import 'package:Chess/screens/game-widgets/pieces/king.dart';
import 'package:Chess/screens/game-widgets/pieces/knight.dart';
import 'package:Chess/screens/game-widgets/pieces/pawn.dart';
import 'package:Chess/screens/game-widgets/pieces/queen.dart';
import 'package:Chess/screens/game-widgets/pieces/rook.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';
import 'package:flutter/material.dart';

Map<SquareNumber, Piece> generateStartingBoard() => {
      ...Map.fromIterable(SquareNumber.values,
          key: (e) => e, value: (_) => null),
      SquareNumber.A1: Rook(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.B1: Knight(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.C1: Bishop(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.D1: Queen(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.E1: King(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.F1: Bishop(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.G1: Knight(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.H1: Rook(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.A2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.B2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.C2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.D2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.E2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.F2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.G2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.H2: Pawn(
        player: Player.White,
        key: UniqueKey(),
      ),
      SquareNumber.A8: Rook(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.B8: Knight(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.C8: Bishop(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.D8: Queen(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.E8: King(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.F8: Bishop(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.G8: Knight(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.H8: Rook(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.A7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.B7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.C7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.D7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.E7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.F7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.G7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
      SquareNumber.H7: Pawn(
        player: Player.Black,
        key: UniqueKey(),
      ),
    };
