import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.setPortraitUpOnly();

  Flame.images.loadAll(<String>['background.png', 'talpa.png', 'bomb.png']);
  Flame.audio.loadAll(<String>['soundtrack.mp3', 'explosion.ogg']);

  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  runApp(gameController.widget);

  //Flame.bgm.play('soundtrack.mp3');
}
