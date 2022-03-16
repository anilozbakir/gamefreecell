import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import "package:flame/game.dart";

// import "package:flame/game.dart";
import 'package:flame/input.dart';
// import 'package:flame/sprite.dart';

// import "dart:math";

// import 'dart:developer' as dv;
// import "RecTouch.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dv;
import "game_board.dart";
import "card.dart" as gCArd;
//import 'package:game2048/game_board.dart';

class MyGame extends FlameGame with KeyboardEvents, HasDraggables {
  GameBoard? gameBoard;
  MyGame() : super();

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // gameBoard = GameBoard();
    // add(gameBoard!);

    await gCArd.Card.loadMainImage();

    var c = gCArd.Card(sizeof: Vector2(100, 100));
    c.position = Vector2(400, 400);
    add(c);
    //   mouseCursor.value = SystemMouseCursors.move;
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      // gameBoard!.RotateAndMovePiece(keysPressed.first);

      // if (keysPressed.first == LogicalKeyboardKey.space) {
      //   while (gameBoard!.checkNewMove(keysPressed.first));
      //   int c = gameBoard!.collusionIndex ~/ gameBoard!.col;
      //   dv.log("$c");
      //   gameBoard!.blowLines(c);

      //   gameBoard!.newPiece();
      //   return KeyEventResult.handled;
      // }

    }
    return KeyEventResult.handled;
  }

  // @override
  // bool onTapDown(TapDownInfo event) {
  //   print("Player tap down on ${event.eventPosition.game}");
  //   return true;
  // }

  // @override
  // bool onTapUp(TapUpInfo event) {
  //   print("Player tap up on ${event.eventPosition.game}");
  //   return true;
  // }

  //   @override
  //   bool onMouseMove(MouseMoveInfo mouseMove) {
  //     return true;
  //   }
  //   // void render(Canvas c) {
  //   //   super.render(c);
  //   // }

  //   // @override
  //   // void update(double dt) {
  //   //   super.update(dt);
  //   // }
}

void main() {
  final myGame = MyGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}