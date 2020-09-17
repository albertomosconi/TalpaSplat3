import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:talpasplat3/game_controller.dart';

class Talpa {
  final GameController gameController;
  final int maxJumpInterval = 2000;
  final int minJumpInterval = 100;
  final int intervalChange = 10;
  int currentInterval;
  int nextJump;

  Rect talpaRect;
  final double size = 50;
  Random rand;

  Talpa(this.gameController) {
    rand = Random();

    reset();
  }

  void reset() {
    currentInterval = maxJumpInterval;

    talpaRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
        gameController.screenSize.height / 2 - size / 2, size, size);

    nextJump = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xFF0000FF);
    c.drawRect(talpaRect, color);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now >= nextJump) {
      jump();
    }
  }

  void onTapDown(TapDownDetails details) {
    jump();
    if (currentInterval > minJumpInterval) {
      currentInterval -= intervalChange;
    }
  }

  void jump() {
    int now = DateTime.now().millisecondsSinceEpoch;

    double x = gameController.screenSize.width * rand.nextDouble();
    if (x + size > gameController.screenSize.width) {
      x = gameController.screenSize.width - size;
    }
    double y = gameController.screenSize.height * rand.nextDouble();
    if (y + size > gameController.screenSize.height) {
      y = gameController.screenSize.height - size;
    }

    talpaRect = Rect.fromLTWH(x, y, size, size);

    nextJump = now + currentInterval;
  }
}
