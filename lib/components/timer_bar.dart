import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talpasplat3/game_controller.dart';

class TimerBar {
  final GameController gameController;
  Rect timerBarRect;
  Rect currentTimeBarRect;
  double barWidth;
  double barHeight;
  Paint currentTimeBarColor;
  Path shadowPath;

  TimerBar(this.gameController) {
    barWidth = gameController.screenSize.width *
        (gameController.currentTime / gameController.gameDuration);
    barHeight = 15.0;

    shadowPath = Path();
    shadowPath.lineTo(barWidth, 0.0);
    shadowPath.lineTo(barWidth, barHeight);
    shadowPath.lineTo(0.0, barHeight);

    currentTimeBarRect = Rect.fromLTWH(
        0,
        gameController.screenSize.height - barHeight - 10.0,
        barWidth,
        barHeight);
  }

  void render(Canvas c) {
    if (barWidth < gameController.screenSize.width * 0.2) {
      currentTimeBarColor = Paint()..color = Color(0xFFFF0000);
    } else {
      currentTimeBarColor = Paint()..color = Color(0xFFFFFFFF);
    }

    c.drawShadow(shadowPath, Colors.black, 8, false);
    c.drawShadow(shadowPath, Colors.black, 8, false);
    c.drawShadow(shadowPath, Colors.black, 8, false);
    c.drawShadow(shadowPath, Colors.black, 8, false);
    c.drawRect(currentTimeBarRect, currentTimeBarColor);
  }

  void update(double t) {
    barWidth = gameController.screenSize.width *
        (1 - gameController.currentTime / gameController.gameDuration);

    shadowPath = Path();
    shadowPath.lineTo(barWidth, 0.0);
    shadowPath.lineTo(barWidth, barHeight);
    shadowPath.lineTo(0.0, barHeight);

    shadowPath = shadowPath.shift(Offset(
        (gameController.screenSize.width - barWidth) / 2,
        gameController.screenSize.height - barHeight - 12.0));

    currentTimeBarRect = Rect.fromLTWH(
        (gameController.screenSize.width - barWidth) / 2,
        gameController.screenSize.height - barHeight - 10.0,
        barWidth,
        barHeight);
  }
}
