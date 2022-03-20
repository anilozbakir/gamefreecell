import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import '../card.dart' as FreeCellCard;
import 'piable.dart';

//this type is the main piles of freecell that are randomly
//placed on screen
class FiledPile implements Piable {
  static int pileDepth = 20;
  static int pileCount = 6;
  static Vector2 start = Vector2(0, 0);
  static Vector2 end = Vector2(0, 0);
  PileType type = PileType.FILEDCELL;

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
    return pileDepth;
  }

  @override
  PileType getType() {
    return type;
  }
}
