import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/components/game_state.dart';
import 'package:talpasplat3/components/highscore_text.dart';
import 'package:talpasplat3/components/start_text.dart';

class GameController extends Game with TapDetector {
  final SharedPreferences storage;
  GameState gameState;
  Size screenSize;
  HighscoreText highscoreText;
  StartText startText;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    gameState = GameState.MENU;
    highscoreText = HighscoreText(this);
    startText = StartText(this);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    switch (gameState) {
      case GameState.MENU:
        startText.render(c);
        highscoreText.render(c);
        break;

      case GameState.PLAYING:
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
        break;
    }
  }
}
