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
  int checkRegion(Vector2 position) {
    // TODO: implement checkRegion
    throw UnimplementedError();
  }

  @override
  List dragCards(card) {
    // TODO: implement dragCards
    throw UnimplementedError();
  }

  @override
  List dropCards(card) {
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
