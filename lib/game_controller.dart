import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/components/game_state.dart';
import 'package:talpasplat3/components/highscore_text.dart';
import 'package:talpasplat3/components/score_text.dart';
import 'package:talpasplat3/components/start_text.dart';
import 'package:talpasplat3/components/talpa.dart';

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
  }

  void render(Canvas c) {
    // Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    // c.drawRect(background, backgroundPaint);

    background.render(c);

    switch (gameState) {
      case GameState.MENU:
        startText.render(c);
        highscoreText.render(c);
        break;

      case GameState.PLAYING:
        talpa.render(c);
        scoreText.render(c);
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
        scoreText.update(t);
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
        break;

      case GameState.PLAYING:
        if (talpa.talpaRect.contains(details.globalPosition)) {
          talpa.onTapDown(details);
        } else {
          talpa.reset();
        }
        break;
    }
  }
}
