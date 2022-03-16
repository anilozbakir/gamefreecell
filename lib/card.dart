//import 'dart:html';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;

enum CardType {
  hearts,
  clubs,
  diamonds,
}

class Card extends SpriteComponent with cmp.Draggable {
  static Sprite? mainPicture;
  static Vector? imageDimensions;
  static Map<CardType, int>? colorToInt;

  static loadMainImage() async {
    //for performance load the main picture once.
    //then cut and move the frame window for what color you want.
    mainPicture =
        await Sprite.load("playcards.png", srcSize: Vector2(168, 240));
    colorToInt = {};
    int index = 0;
    CardType.values.forEach((element) {
      colorToInt![element] = index++;
    });
  }

  // Future<void>? onLoad() async {
  //   await super.onLoad();
  // }
  Vector2 sizeof;
  int cardIndex = 0;
  Vector2 _diff=Vector2(0,0);
  Card({required this.sizeof}) : super(size: sizeof) {
    sprite = Sprite(mainPicture!.image,
        srcPosition: Vector2(0, 0), srcSize: Vector2(168, 240));
  }
  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    print("cards position ${position}");
    print("Player drag start on ${info.raw.globalPosition}");
    _diff.x = position.x - info.raw.globalPosition.dx;
    _diff.y = position.y - info.raw.globalPosition.dy;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    // final localCoords = event.eventPosition.game;
    position.x = _diff.x + info.raw.globalPosition.dx;
    position.y = _diff.y + info.raw.globalPosition.dy;
    // print(
    //     "position ${position.x} ${position.y}   change ${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}");
    return false;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo event) {
    print("Player drag end on ");
    return false;
  }

  @override
  bool onDragCancel(int pointerId) {
    //dragDeltaPosition = null;
    return false;
  }
}
