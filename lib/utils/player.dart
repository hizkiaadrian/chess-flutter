enum Player { White, Black }

extension PlayerUtils on Player {
  String asString() => toString().split(".").last;

  Player getOpponent() => this == Player.White ? Player.Black : Player.White;
}
