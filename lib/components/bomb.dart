import 'dart:math';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:talpasplat3/game_controller.dart';

class Bomb {
  final GameController gameController;

  Rect bombRect;
  Sprite bombSprite;
  final double size = 50.0;

  Random rand;

  Bomb(this.gameController) {
    rand = Random();
    bombSprite = Sprite('bomb.png');
    bombRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
        gameController.screenSize.height / 2 - size / 2, size, size * 1.2);
  }

  void render(Canvas c) {
    bombSprite.renderRect(c, bombRect);
  }

  void update(double t) {}

  void onTapDown(TapDownDetails details) {}
}
