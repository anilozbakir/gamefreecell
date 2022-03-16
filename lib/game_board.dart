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
import "card.dart" as gCArd;
import "package:flame/components.dart" as cmp;

class GameBoard extends PositionComponent {
  @override
  onLoad() async {
    await super.onLoad();
    await gCArd.Card.loadMainImage();
    // size = Vector2(400, 600);
    // var c = gCArd.Card(sizeof: Vector2(100, 100));
    // c.position = Vector2(400, 400);
    // add(c);
  }

  GameBoard({size}) : super(size: size) {}
}
