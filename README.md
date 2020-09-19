# Chess with Flutter

Welcome! This Flutter app is a simple chess game I created mainly to learn Flutter. Feel free to fork this repository or submit a pull request on this repository.

## v1.1 - Intro of bots

- Display captured pieces in game view
- Player bot that makes random moves
- Two game modes: Against AI and PvP on same device
- Choose player color if against AI

## v1.0 - First release

- Implement all of chess rules, including check, castling, en passant, and pawn promotion
- Add a functionality to start a new game and continue existing game
- Show "CHECK" message when player in turn is in check
- Show "Checkmate" dialog when checkmate happens

# Future work

- Undo button
Wouldn't it be nice if you can always undo a bad move? One might argue not, but I will implement this anyway

- Timed mode
Currently, the game is in Zen mode, i.e. no time limit. Having a timer will make the game more challenging and truly feel like an actual chess game

- Multi-device mode
As mentioned in the section above, the GameProvider contains all the necessary data to make the game run. Therefore, by storing the Provider data elsewhere for two (or even more) devices to access, the game can be played by two devices, both in real-time and in zen mode

- User login/register and ELO rating
- Audio

# Developer notes
The aim for this project is simply for me to learn Flutter, as well as a little bit of game development. Every time I have a desire to learn game development, I have been stunted by my lack of desire to do the graphics part (designing, etc.). If you're in the same situation, feel free to fork this repo and use my assets - I got them from Google anyway.

Lastly, if you'd like to collab and work on the future work, please don't hesitate to contact me at hizkiaadrians@gmail.com
