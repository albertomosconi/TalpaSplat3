import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.images.loadAll(<String>['background.png', 'talpa.png', 'bomb.png']);
  Flame.audio.loadAll(<String>['soundtrack.mp3', 'explosion.ogg']);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  await Flame.audio.loopLongAudio('soundtrack.mp3', volume: .5);

  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  runApp(gameController.widget);
}
