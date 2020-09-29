import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talpasplat3/bgm.dart';
import 'package:talpasplat3/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();

  Flame.images.loadAll(<String>[
    'background.png',
    'talpa.png',
    'bomb.png',
    'ui/title.png',
    'ui/start-button.png',
    'ui/home-button.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
  ]);

  Flame.audio.loadAll(<String>['explosion.mp3']);
  BGM.attachWidgetBindingListener();
  await BGM.add('soundtrack.mp3');

  GameController gameController = GameController(storage);
  runApp(gameController.widget);
}
