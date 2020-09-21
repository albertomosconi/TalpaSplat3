import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:talpasplat3/game_controller.dart';

class Talpa {
  final GameController gameController;
  final int maxJumpInterval = 2000;
  final int minJumpInterval = 100;
  final int intervalChange = 20;
  int currentInterval;
  int nextJump;

  Rect talpaRect;
  Sprite talpaSprite;
  final double size = 80;
  Random rand;

  Talpa(this.gameController) {
    rand = Random();
    talpaSprite = Sprite('talpa.png');

    reset();
  }

  void reset() {
    HapticFeedback.vibrate();
    HapticFeedback.vibrate();
    HapticFeedback.vibrate();

    gameController.score = 0;
    currentInterval = maxJumpInterval;

    //talpaRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
    //    gameController.screenSize.height / 2 - size / 2, size, size);

    nextJump = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void render(Canvas c) {
    talpaSprite.renderRect(c, talpaRect);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now >= nextJump) {
      jump();
    }
  }

  void onTapDown(TapDownDetails details) {
    HapticFeedback.lightImpact();
    jump();
    if (currentInterval > minJumpInterval) {
      currentInterval -= intervalChange;
    }
    gameController.score++;
    if (gameController.score >
        (gameController.storage.getInt('highscore') ?? 0)) {
      gameController.storage.setInt('highscore', gameController.score);
    }
  }

  void jump() {
    int now = DateTime.now().millisecondsSinceEpoch;

    double x = gameController.screenSize.width * rand.nextDouble();
    if (x + size > gameController.screenSize.width) {
      x = gameController.screenSize.width - size;
    }
    double y =
        gameController.screenSize.height * (0.25 + rand.nextDouble() % 0.5) -
            size / 2;

    talpaRect = Rect.fromLTWH(x, y, size, size);

    nextJump = now + currentInterval;
  }
}
