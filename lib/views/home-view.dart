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
  Rect helpIconRect;
  Sprite helpIconSprite;
  Rect creditsIconRect;
  Sprite creditsIconSprite;

  HomeView(this.gameController) {
    background = Background(gameController, 'background.png');

    titleRect = Rect.fromLTWH(
      gameController.tileSize,
      (gameController.screenSize.height / 2) - (gameController.tileSize * 6),
      gameController.tileSize * 7,
      gameController.tileSize * 4,
    );
    titleSprite = Sprite('ui/title.png');

    startButtonRect = Rect.fromLTWH(
      gameController.tileSize * 2.5,
      (gameController.screenSize.height * .75) - (gameController.tileSize),
      gameController.tileSize * 4,
      gameController.tileSize * 2,
    );
    startButtonSprite = Sprite('ui/start-button.png');

    helpIconRect = Rect.fromLTWH(
      gameController.tileSize * .25,
      gameController.screenSize.height - (gameController.tileSize * 1.25),
      gameController.tileSize,
      gameController.tileSize,
    );
    helpIconSprite = Sprite('ui/icon-help.png');

    creditsIconRect = Rect.fromLTWH(
      gameController.screenSize.width - (gameController.tileSize * 1.25),
      gameController.screenSize.height - (gameController.tileSize * 1.25),
      gameController.tileSize,
      gameController.tileSize,
    );
    creditsIconSprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas c) {
    background.render(c);

    titleSprite.renderRect(c, titleRect);
    startButtonSprite.renderRect(c, startButtonRect);
    // helpIconSprite.renderRect(c, helpIconRect);
    // creditsIconSprite.renderRect(c, creditsIconRect);
  }

  void update(double t) {}
}
