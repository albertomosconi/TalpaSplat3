import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:talpasplat3/components/background.dart';
import 'package:talpasplat3/game_controller.dart';

class EndView {
  final GameController gameController;

  Background background;

  Rect homeButtonRect;
  Sprite homeButtonSprite;
  Rect playAgainButtonRect;
  Sprite playAgainButtonSprite;

  EndView(this.gameController) {
    background = Background(gameController, 'background.png');

    homeButtonRect = Rect.fromLTWH(
      gameController.tileSize * 1.5,
      (gameController.screenSize.height * .75),
      gameController.tileSize * 3,
      gameController.tileSize * 1.5,
    );
    homeButtonSprite = Sprite('ui/home-button.png');

    playAgainButtonRect = Rect.fromLTWH(
      gameController.tileSize * 4.5,
      (gameController.screenSize.height * .75),
      gameController.tileSize * 3,
      gameController.tileSize * 1.5,
    );
    playAgainButtonSprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    background.render(c);

    homeButtonSprite.renderRect(c, homeButtonRect);
    playAgainButtonSprite.renderRect(c, playAgainButtonRect);
  }
}
