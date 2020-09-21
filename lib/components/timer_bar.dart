import 'dart:ui';

import 'package:talpasplat3/game_controller.dart';

class TimerBar {
  final GameController gameController;
  Rect timerBarRect;
  Rect currentTimeBarRect;
  double barWidth;
  double barHeight;
  Paint currentTimeBarColor;

  TimerBar(this.gameController) {
    barWidth = gameController.screenSize.width *
        (gameController.currentTime / gameController.gameDuration);
    barHeight = 30.0;

    //timerBarRect = Rect.fromLTWH(
    //    0, gameController.screenSize.height - barHeight, barWidth, barHeight);

    currentTimeBarRect = Rect.fromLTWH(
        0, gameController.screenSize.height - barHeight, barWidth, barHeight);
  }

  void render(Canvas c) {
    if (barWidth < gameController.screenSize.width * 0.2) {
      currentTimeBarColor = Paint()..color = Color(0xFFFF0000);
    } else {
      currentTimeBarColor = Paint()..color = Color(0xFFFFFFFF);
    }
    c.drawRect(currentTimeBarRect, currentTimeBarColor);
  }

  void update(double t) {
    barWidth = gameController.screenSize.width *
        (1 - gameController.currentTime / gameController.gameDuration);

    currentTimeBarRect = Rect.fromLTWH(
        0, gameController.screenSize.height - barHeight, barWidth, barHeight);
  }
}
