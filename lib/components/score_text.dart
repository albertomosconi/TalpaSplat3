import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talpasplat3/game_controller.dart';

class ScoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  ScoreText(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;

    painter.text = TextSpan(
        text: gameController.score.toString(),
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
            shadows: <Shadow>[
              Shadow(
                  blurRadius: 7, color: Color(0xff000000), offset: Offset(3, 3))
            ]));
    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.15) - (painter.height / 2),
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text ?? '') != gameController.score.toString()) {
      painter.text = TextSpan(
          text: gameController.score.toString(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              shadows: <Shadow>[
                Shadow(
                    blurRadius: 7,
                    color: Color(0xff000000),
                    offset: Offset(3, 3))
              ]));
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2) - (painter.width / 2),
        (gameController.screenSize.height * 0.15) - (painter.height / 2),
      );
    }
  }
}
