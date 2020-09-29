import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/bgm.dart';
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

  int score;

  Talpa talpa;
  BombSpawner bombSpawner;

  Timer countdown;
  final double gameDuration = 30.0;
  double currentTime;

  AudioPlayer bgm;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    homeView = HomeView(this);

    score = 0;

    talpa = Talpa(this);
    bombSpawner = BombSpawner(this);

    countdown = Timer(gameDuration);
    currentTime = gameDuration;

    BGM.play(0);
  }

  void render(Canvas c) {
    switch (activeView) {
      case View.HOME:
        homeView.render(c);
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
          talpa.reset();
          bombSpawner.reset();
          countdown.start();
        }
        break;

      case View.PLAYING:
        if (bombSpawner.bomb.bombRect.contains(details.globalPosition)) {
          Flame.audio.play('explosion.mp3');
          bombSpawner.reset();
          talpa.reset();
        } else if (talpa.talpaRect.contains(details.globalPosition)) {
          talpa.onTapDown(details);
        }
        break;

      case View.END:
        if (endView.homeButtonRect.contains(details.globalPosition)) {
          activeView = View.HOME;
        } else if (endView.playAgainButtonRect
            .contains(details.globalPosition)) {
          activeView = View.PLAYING;
          playingView = PlayingView(this);
          talpa.reset();
          bombSpawner.reset();
          countdown.start();
        }
        break;
    }
  }
}
