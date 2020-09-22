import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:talpasplat3/components/bomb.dart';
import 'package:talpasplat3/game_controller.dart';

class BombSpawner {
  final GameController gameController;

  Bomb bomb;

  Random rand;

  bool show = true;

  BombSpawner(this.gameController) {
    rand = Random();
    bomb = Bomb(gameController, gameController.screenSize.width / 2,
        gameController.screenSize.width / 2);
  }
  void render(Canvas c) {
    if (show) {
      bomb.render(c);
    }
  }

  void update(double t) {}
}
