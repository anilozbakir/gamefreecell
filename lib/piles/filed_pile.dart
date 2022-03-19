import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import '../card.dart' as FreeCellCard;
import 'piable.dart';

//this type is the main piles of freecell
class FiledPile implements Piable {
  static const int maxElements = 20;
  int cardIndex = 0;

  @override
  int checkRegion(Vector2 position) {
    // TODO: implement checkRegion
    throw UnimplementedError();
  }

  @override
  List<FreeCellCard.Card> dragCards(FreeCellCard.Card card) {
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
}
