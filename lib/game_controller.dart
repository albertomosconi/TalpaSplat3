import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/components/bomb.dart';
import 'package:talpasplat3/components/game_state.dart';
import 'package:talpasplat3/components/highscore_text.dart';
import 'package:talpasplat3/components/score_text.dart';
import 'package:talpasplat3/components/start_text.dart';
import 'package:talpasplat3/components/talpa.dart';
import 'package:talpasplat3/components/timer_bar.dart';

class GameController extends Game with TapDetector {
  final SharedPreferences storage;
  GameState gameState;
  Size screenSize;
  HighscoreText highscoreText;
  StartText startText;
  Sprite background;

  int score;
  ScoreText scoreText;

  Talpa talpa;
  Bomb bomb;

  Timer countdown;
  final double gameDuration = 60.0;
  double currentTime;
  TimerBar timerBar;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    gameState = GameState.MENU;
    highscoreText = HighscoreText(this);
    startText = StartText(this);
    background = Sprite('background.png');

    score = 0;
    scoreText = ScoreText(this);

    talpa = Talpa(this);
    bomb = Bomb(this);

    countdown = Timer(gameDuration);
    currentTime = gameDuration;
    timerBar = TimerBar(this);
  }

  void render(Canvas c) {
    Rect backgroundRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);

    background.renderRect(c, backgroundRect);

    switch (gameState) {
      case GameState.MENU:
        startText.render(c);
        highscoreText.render(c);
        break;

      case GameState.PLAYING:
        talpa.render(c);
        bomb.render(c);
        scoreText.render(c);
        timerBar.render(c);
        break;
    }
  }

  void update(double t) {
    switch (gameState) {
      case GameState.MENU:
        startText.update(t);
        highscoreText.update(t);
        break;

      case GameState.PLAYING:
        talpa.update(t);
        bomb.update(t);

        scoreText.update(t);

        countdown.update(t);
        currentTime = countdown.current.toDouble();
        if (countdown.isFinished()) {
          talpa.reset();
          gameState = GameState.MENU;
        }
        timerBar.update(t);
        break;
    }
  }

  void resize(Size size) {
    screenSize = size;
  }

  @override
  void onTapDown(TapDownDetails details) {
    switch (gameState) {
      case GameState.MENU:
        gameState = GameState.PLAYING;
        countdown.start();
        break;

      case GameState.PLAYING:
        if (bomb.bombRect.contains(details.globalPosition)) {
          talpa.reset();
          //gameState = GameState.MENU;
        } else if (talpa.talpaRect.contains(details.globalPosition)) {
          talpa.onTapDown(details);
        }

        break;
    }
  }
}
