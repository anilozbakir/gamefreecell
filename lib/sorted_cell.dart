import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import "card.dart" as FreeCellCard;
import "piable.dart";

class FreeCellPile implements Piable {
  @override
  int CheckRegion(Vector2 position) {
    // TODO: implement CheckRegion
    throw UnimplementedError();
  }

  @override
  List<FreeCellCard.Card> DragCards(FreeCellCard.Card card) {
    // TODO: implement DragCards
    throw UnimplementedError();
  }

  @override
  List<FreeCellCard.Card> DropCards(FreeCellCard.Card card) {
    // TODO: implement DropCards
    throw UnimplementedError();
  }

  @override
  int GetMax() {
    // TODO: implement GetMax
    throw UnimplementedError();
  }
}
