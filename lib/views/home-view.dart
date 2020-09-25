import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:talpasplat3/components/background.dart';
import 'package:talpasplat3/game_controller.dart';

class HomeView {
  final GameController gameController;

  Background background;

  Rect titleRect;
  Sprite titleSprite;
  Rect startButtonRect;
  Sprite startButtonSprite;

  HomeView(this.gameController) {
    background = Background(gameController, 'background.png');

    titleRect = Rect.fromLTWH(
      gameController.tileSize,
      (gameController.screenSize.height / 2) - (gameController.tileSize * 4),
      gameController.tileSize * 7,
      gameController.tileSize * 4,
    );
    titleSprite = Sprite('ui/title.png');

    startButtonRect = Rect.fromLTWH(
      gameController.tileSize * 1.5,
      (gameController.screenSize.height * .75) -
          (gameController.tileSize * 1.5),
      gameController.tileSize * 6,
      gameController.tileSize * 3,
    );
    startButtonSprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    background.render(c);

    titleSprite.renderRect(c, titleRect);
    startButtonSprite.renderRect(c, startButtonRect);
  }

  void update(double t) {}
}
