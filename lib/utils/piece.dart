import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/utils/square.dart';

enum PieceName { Pawn, Knight, Bishop, Rook, Queen, King }

extension PieceUtils on PieceName {
  String asString() => toString().split('.').last;
}

List<SquareNumber> exploreInOneDirection(SquareNumber currentPosition,
    BoardState boardState, Player player, int unitRow, int unitCol) {
  List<SquareNumber> moves = [];

  int i = 1;
  SquareNumber squareToExplore =
      currentPosition.getSquareInDirection(unitRow * i, unitCol * i);
  while (squareToExplore != null) {
    if (boardState.piecePosition[squareToExplore] == null) {
      moves.add(squareToExplore);
    } else if (boardState.piecePosition[squareToExplore].player == player) {
      break;
    } else {
      moves.add(squareToExplore);
      break;
    }
    i++;
    squareToExplore =
        currentPosition.getSquareInDirection(unitRow * i, unitCol * i);
  }

  return moves;
}
