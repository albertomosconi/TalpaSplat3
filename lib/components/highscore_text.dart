import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talpasplat3/game_controller.dart';

class HighscoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  HighscoreText(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;

    int highscore = gameController.storage.getInt('highscore') ?? 0;
    painter.text = TextSpan(
        text: 'Highscore: $highscore',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            shadows: <Shadow>[
              Shadow(
                  blurRadius: 7, color: Color(0xff000000), offset: Offset(3, 3))
            ]));
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.4) - (painter.height / 2),
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
}
