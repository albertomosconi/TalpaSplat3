import 'dart:math';

import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:talpasplat3/game_controller.dart';

class Bomb {
  final GameController gameController;
  final int maxJumpInterval = 2000;
  final int minJumpInterval = 100;
  final int intervalChange = 20;
  int currentInterval;
  int nextJump;

  Rect bombRect;
  Sprite bombSprite;
  final double size = 80.0;

  Random rand;

  Bomb(this.gameController) {
    rand = Random();
    bombRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
        gameController.screenSize.height / 2 - size / 2, size, size);
  }

  void render(Canvas c) {
    Paint bombPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(bombRect, bombPaint);
  }

  void update(double t) {}

  void onTapDown(TapDownDetails details) {}
}
