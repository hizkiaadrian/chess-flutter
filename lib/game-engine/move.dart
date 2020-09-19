import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/utils/square.dart';

class Move {
  final Piece piece;
  final SquareNumber destination;

  Move({this.piece, this.destination});
}
