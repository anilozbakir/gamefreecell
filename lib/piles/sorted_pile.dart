import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import '../card.dart' as FreeCellCard;
import 'piable.dart';

class SortedCell implements Piable {
  @override
  List<FreeCellCard.Card> startDrag(FreeCellCard.Card card) {
    // TODO: implement dragCards
    throw UnimplementedError();
  }

  @override
  List<FreeCellCard.Card> dropCards(FreeCellCard.Card card) {
    // TODO: implement dropCards
    throw UnimplementedError();
  }

  @override
  int getMax() {
    // TODO: implement getMax
    throw UnimplementedError();
  }

  @override
  PileType getType() {
    // TODO: implement getType
    throw UnimplementedError();
  }

  @override
  Vector2 getEndPoint() {
    // TODO: implement getEndPoint
    throw UnimplementedError();
  }

  @override
  Vector2 getStartPoint() {
    // TODO: implement getStartPoint
    throw UnimplementedError();
  }

  @override
  bool checkRegion(Vector2 position) {
    Vector2 start = getStartPoint();
    Vector2 end = getEndPoint();

    if (position.x > start.x && position.x < end.x) {
      if (position.y > start.y && position.y < end.x) {
        //TODO place the card in the pile and create a last move
        //info to be used in undo
        return true;
      }
    }
    return false;
  }
}
