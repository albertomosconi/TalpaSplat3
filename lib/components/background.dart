import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:talpasplat3/game_controller.dart';

class Background {
  final GameController gameController;

  Sprite bgSprite;
  Rect bgRect;

  Background(this.gameController, String spriteName) {
    bgSprite = Sprite(spriteName);
    bgRect = Rect.fromLTWH(
      0,
      gameController.screenSize.height - (gameController.tileSize * 23),
      gameController.tileSize * 9,
      gameController.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
