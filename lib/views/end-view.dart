import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:talpasplat3/components/background.dart';
import 'package:talpasplat3/components/highscore_text.dart';
import 'package:talpasplat3/components/score_text.dart';
import 'package:talpasplat3/game_controller.dart';

class EndView {
  final GameController gameController;

  Background background;

  HighscoreText highscoreText;
  ScoreText scoreText;

  Rect homeButtonRect;
  Sprite homeButtonSprite;
  Rect playAgainButtonRect;
  Sprite playAgainButtonSprite;

  EndView(this.gameController) {
    background = Background(gameController, 'background.png');

    highscoreText = HighscoreText(gameController);
    scoreText = ScoreText(gameController);

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

    highscoreText.render(c);
    scoreText.render(c);

    homeButtonSprite.renderRect(c, homeButtonRect);
    playAgainButtonSprite.renderRect(c, playAgainButtonRect);
  }
}
