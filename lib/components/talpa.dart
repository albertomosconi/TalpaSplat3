import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:talpasplat3/game_controller.dart';

class Talpa {
  final GameController gameController;
  final int maxJumpInterval = 1500;
  final int minJumpInterval = 100;
  final int intervalChange = 15;
  int currentInterval;
  int nextJump;

  Rect talpaRect;
  //Sprite talpaSprite;
  List<Sprite> talpaSprite;
  double talpaSpriteIndex = 0;
  final double size = 80;
  Random rand;

  Talpa(this.gameController) {
    rand = Random();

    talpaSprite = List<Sprite>();
    talpaSprite.add(Sprite('talpa.png'));

    reset();
  }

  void reset() {
    HapticFeedback.vibrate();
    HapticFeedback.vibrate();
    HapticFeedback.vibrate();

    gameController.score = 0;
    currentInterval = maxJumpInterval;

    talpaRect = Rect.fromLTWH(
        gameController.screenSize.width / 2,
        gameController.screenSize.height / 2,
        gameController.tileSize * 1.5,
        gameController.tileSize * 0.55 * 1.5);

    nextJump = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void render(Canvas c) {
    talpaSprite[talpaSpriteIndex.toInt()].renderRect(c, talpaRect.inflate(2));
  }

  void update(double t) {
    talpaSpriteIndex += 30 * t;
    if (talpaSpriteIndex >= talpaSprite.length) {
      talpaSpriteIndex = 0;
    }

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

    if (gameController.score % 5 == 0 && gameController.score != 0) {
      gameController.bombSpawner.maxWaitForBomb = max(
          gameController.bombSpawner.maxWaitForBomb - 1.0,
          gameController.bombSpawner.minWaitForBomb);

      gameController.bombSpawner.maxShowDuration = max(
          gameController.bombSpawner.maxShowDuration - 0.1,
          gameController.bombSpawner.minShowDuration);
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

    talpaRect = Rect.fromLTWH(x, y, gameController.tileSize * 1.5,
        gameController.tileSize * 0.55 * 1.5);

    nextJump = now + currentInterval;
  }
}
