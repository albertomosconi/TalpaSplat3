import 'dart:ui';

import 'package:talpasplat3/components/background.dart';
import 'package:talpasplat3/components/score_text.dart';
import 'package:talpasplat3/components/timer_bar.dart';
import 'package:talpasplat3/game_controller.dart';

class PlayingView {
  final GameController gameController;

  Background background;

  ScoreText scoreText;
  TimerBar timerBar;

  PlayingView(this.gameController) {
    background = Background(gameController, 'background.png');

    scoreText = ScoreText(gameController);
    timerBar = TimerBar(gameController);
  }

  void render(Canvas c) {
    background.render(c);

    scoreText.render(c);
    timerBar.render(c);
  }

  void update(double t) {
    scoreText.update(t);
    timerBar.update(t);
  }
}
