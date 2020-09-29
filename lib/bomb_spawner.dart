import 'dart:math';

import 'package:flame/time.dart';
import 'package:flutter/painting.dart';
import 'package:talpasplat3/components/bomb.dart';
import 'package:talpasplat3/game_controller.dart';

class BombSpawner {
  final GameController gameController;

  Bomb bomb;

  Random rand;

  bool show = false;

  double maxWaitForBomb;
  final double minWaitForBomb = 0.5;
  double maxShowDuration;
  final double minShowDuration = 0.5;
  Timer spawnCountdown;
  Timer showCountdown;

  BombSpawner(this.gameController) {
    rand = Random();
    bomb = Bomb(gameController, gameController.screenSize.width / 2,
        gameController.screenSize.width / 2);

    reset();
  }

  void reset() {
    show = false;
    bomb = Bomb(gameController, -100, -100);

    maxWaitForBomb = 10.0;
    maxShowDuration = 3.0;

    spawnCountdown = Timer(
        minWaitForBomb + rand.nextDouble() * (maxWaitForBomb - minWaitForBomb));
    spawnCountdown.start();

    showCountdown = Timer(minShowDuration +
        rand.nextDouble() * (maxShowDuration - minShowDuration));
  }

  void render(Canvas c) {
    if (show) {
      bomb.render(c);
    }
  }

  void update(double t) {
    spawnCountdown.update(t);
    showCountdown.update(t);

    if (spawnCountdown.isFinished()) {
      if (showCountdown.isRunning()) {
      } else {
        if (showCountdown.isFinished() && show) {
          show = false;

          bomb = Bomb(gameController, -100, -100);

          spawnCountdown = Timer(minWaitForBomb +
              rand.nextDouble() * (maxWaitForBomb - minWaitForBomb));
          spawnCountdown.start();
        } else {
          show = true;

          double x = gameController.screenSize.width * rand.nextDouble();
          if (x + bomb.size > gameController.screenSize.width) {
            x = gameController.screenSize.width - bomb.size;
          }
          double y = gameController.screenSize.height *
                  (0.25 + rand.nextDouble() % 0.5) -
              bomb.size / 2;

          bomb = Bomb(gameController, x, y);

          showCountdown = Timer(minShowDuration +
              rand.nextDouble() * (maxShowDuration - minShowDuration));
          showCountdown.start();
        }
      }
    }
  }
}
