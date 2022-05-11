import 'package:flame/components.dart';
import "package:flutter/foundation.dart";
import "package:flame/flame.dart";
import "package:flutter/material.dart";
import "dart:math";
import "package:flame/components.dart" as cmp;

class ScreenConstants {
  var scale = Vector2(0.5, 0.5);
  var cardSize = Vector2(168, 100);
  var pileArea = Vector2(150, 30);
  var StartFreePile = Vector2(0, 0);
  var StartFiledPile = Vector2(0, 0);
  var StartSortedPile = Vector2(0, 0);
  var stepx = Vector2(0, 0);
  var stepy = Vector2(0, 0);
  ScreenConstants() {}
  ScreenConstants.Android() {
    scale = Vector2(0.5, 0.5);
    cardSize = Vector2(168, 100);
    pileArea = Vector2(150, 30);
    StartFreePile = Vector2(0, 0);
    StartFiledPile = Vector2(0, 0);
    StartSortedPile = Vector2(0, 0);
    stepx = Vector2(0, 0);
    stepy = Vector2(0, 0);
  }

  ScreenConstants.Windows() {
    scale = Vector2(0.5, 0.5);
    cardSize = Vector2(168, 100);
    pileArea = Vector2(150, 30);
    StartFreePile = Vector2(0, 0);
    StartFiledPile = Vector2(0, 0);
    StartSortedPile = Vector2(0, 0);
    stepx = Vector2(0, 0);
    stepy = Vector2(0, 0);
  }
}

class Constants {
  static Map<TargetPlatform, ScreenConstants> constants = {
    TargetPlatform.android: ScreenConstants.Android(),
    TargetPlatform.windows: ScreenConstants.Windows(),
  };
}
