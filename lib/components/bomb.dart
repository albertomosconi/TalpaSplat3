import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:talpasplat3/game_controller.dart';

class Bomb {
  final GameController gameController;

  Rect bombRect;
  Sprite bombSprite;
  final double size = 50.0;

  Bomb(this.gameController, double x, double y) {
    bombSprite = Sprite('bomb.png');
    bombRect = Rect.fromLTWH(x, y, size, size * 1.2);
  }

  void render(Canvas c) {
    bombSprite.renderRect(c, bombRect);
  }

  void update(double t) {}

  void onTapDown(TapDownDetails details) {}
}
