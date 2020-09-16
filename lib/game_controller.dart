import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/components/enemy.dart';
import 'package:talpasplat3/components/health_bar.dart';
import 'package:talpasplat3/components/highscore_text.dart';

import 'dart:ui';

import 'package:talpasplat3/components/player.dart';
import 'package:talpasplat3/components/score_text.dart';
import 'package:talpasplat3/components/start_text.dart';
import 'package:talpasplat3/enemy_spawner.dart';
import 'package:talpasplat3/state.dart';

class GameController extends Game with TapDetector {
  final SharedPreferences storage;
  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  GameState state;
  HighscoreText highscoreText;
  StartText startText;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = GameState.MENU;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highscoreText = HighscoreText(this);
    startText = StartText(this);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    player.render(c);

    if (state == GameState.MENU) {
      startText.render(c);
      highscoreText.render(c);
    } else if (state == GameState.PLAYING) {
      enemies.forEach((Enemy enemy) => enemy.render(c));
      scoreText.render(c);
      healthBar.render(c);
    }
  }

  void update(double t) {
    if (state == GameState.MENU) {
      startText.update(t);
      highscoreText.update(t);
    } else if (state == GameState.PLAYING) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  @override
  void onTapDown(TapDownDetails d) {
    if (state == GameState.MENU) {
      state = GameState.PLAYING;
    } else if (state == GameState.PLAYING) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
        // top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
        // right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        // bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        // left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.width;
        break;
    }
    enemies.add(Enemy(this, x, y));
  }
}
