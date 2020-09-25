import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/bomb_spawner.dart';
import 'package:talpasplat3/components/talpa.dart';
import 'package:talpasplat3/view.dart';
import 'package:talpasplat3/views/end-view.dart';
import 'package:talpasplat3/views/home-view.dart';
import 'package:talpasplat3/views/playing-view.dart';

class GameController extends Game with TapDetector {
  Size screenSize;
  double tileSize;

  View activeView = View.HOME;
  HomeView homeView;
  PlayingView playingView;
  EndView endView;

  final SharedPreferences storage;
  //HighscoreText highscoreText;
  //StartText startText;

  int score;

  Talpa talpa;
  BombSpawner bombSpawner;

  Timer countdown;
  final double gameDuration = 10.0;
  double currentTime;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    homeView = HomeView(this);

    //highscoreText = HighscoreText(this);
    //startText = StartText(this);

    score = 0;

    talpa = Talpa(this);
    bombSpawner = BombSpawner(this);

    countdown = Timer(gameDuration);
    currentTime = gameDuration;
  }

  void render(Canvas c) {
    switch (activeView) {
      case View.HOME:
        homeView.render(c);
        //startText.render(c);
        //highscoreText.render(c);
        break;

      case View.PLAYING:
        playingView.render(c);

        talpa.render(c);
        bombSpawner.render(c);
        break;
      case View.END:
        endView.render(c);
        break;
    }
  }

  void update(double t) {
    switch (activeView) {
      case View.HOME:
        //startText.update(t);
        //highscoreText.update(t);
        break;

      case View.PLAYING:
        playingView.update(t);

        talpa.update(t);
        bombSpawner.update(t);

        countdown.update(t);
        currentTime = countdown.current.toDouble();
        if (countdown.isFinished()) {
          if (score > (storage.getInt('highscore') ?? 0)) {
            storage.setInt('highscore', score);
          }
          bombSpawner.reset();
          talpa.reset();
          activeView = View.END;
          endView = EndView(this);
        }
        break;
      case View.END:
        break;
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

    super.resize(size);
  }

  @override
  void onTapDown(TapDownDetails details) {
    switch (activeView) {
      case View.HOME:
        if (homeView.startButtonRect.contains(details.globalPosition)) {
          activeView = View.PLAYING;
          playingView = PlayingView(this);
          countdown.start();
        }
        break;

      case View.PLAYING:
        if (bombSpawner.bomb.bombRect.contains(details.globalPosition)) {
          Flame.audio.play('explosion.ogg');
          bombSpawner.reset();
          talpa.reset();
        } else if (talpa.talpaRect.contains(details.globalPosition)) {
          talpa.onTapDown(details);
        }
        break;

      case View.END:
        if (endView.homeButtonRect.contains(details.globalPosition))
          activeView = View.HOME;
        break;
    }
  }
}
