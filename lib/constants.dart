import 'package:flame/components.dart';
import "package:flutter/foundation.dart";
import "package:flame/flame.dart";
import "package:flutter/material.dart";
import "dart:math";
import "package:flame/components.dart" as cmp;

class ScreenConstants {
  var scale = Vector2(0.5, 0.5);
  var cardSize = Vector2(341.14, 473);

  // var freeCellPile = PileProperties.freePile();
  // var filePile = PileProperties.filePile();
  // var sortedPile = PileProperties.sortedPile();
  ScreenConstants() {}
  ScreenConstants.Android() {
    scale = Vector2(0.25, 0.25);
    cardSize = Vector2(341.14, 473);
  }

  ScreenConstants.Windows() {
    scale = Vector2(0.3, 0.3);
    cardSize = Vector2(341.14, 473);
  }
}

class Constants {
  static Map<TargetPlatform, ScreenConstants> constants = {
    TargetPlatform.android: ScreenConstants.Android(),
    TargetPlatform.windows: ScreenConstants.Windows(),
  };
}

class PileProperties {
  var stepx = Vector2(0, 0);
  var stepy = Vector2(0, 0);
  var depthx = 0;
  var depthy = 0;
  var pileBase = Vector2(0, 0);
  ScreenConstants constants = Constants.constants[TargetPlatform.android]!;
  PileProperties.freePile(TargetPlatform platform) {
    constants = Constants.constants[platform]!;
    var cardSize = Vector2(constants.cardSize.x * constants.scale.x,
        constants.cardSize.y * constants.scale.y);
    pileBase = Vector2(cardSize.x * 0.1, cardSize.y * 0.1);

    stepx = Vector2(1.2 * cardSize.x, 0);
    stepy = Vector2(0, cardSize.y);
    depthx = 4;
    depthy = 1;
  }
  PileProperties.filePile(TargetPlatform platform) {
    constants = Constants.constants[platform]!;
    var cardSize = Vector2(constants.cardSize.x * constants.scale.x,
        constants.cardSize.y * constants.scale.y);
    pileBase = Vector2(cardSize.x * 0.1, cardSize.y * 1.3);

    stepx = Vector2(1.1 * cardSize.x, 0);
    stepy = Vector2(0, 0.3 * cardSize.y);
    depthx = 8;
    depthy = 20;
  }
  PileProperties.sortedPile(TargetPlatform platform) {
    constants = Constants.constants[platform]!;
    var cardSize = Vector2(constants.cardSize.x * constants.scale.x,
        constants.cardSize.y * constants.scale.y);
    pileBase = Vector2(cardSize.x * 6, cardSize.y * 0.1);

    stepx = Vector2(1.2 * cardSize.x, 0);
    stepy = Vector2(0, 0);
    depthx = 4;
    depthy = 1;
  }
}
