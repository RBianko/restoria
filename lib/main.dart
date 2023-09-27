import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restoria/src/objects/enemy/goblin_controller.dart';
import 'package:restoria/src/objects/playerHero/player_hero_controller.dart';
import 'package:restoria/src/objects/util/interface/bars/HP/bars_controller.dart';
import 'package:restoria/src/objects/util/interface/menus/hero_menu_controller.dart';
import 'package:restoria/src/objects/util/providers/bgm_manager.dart';
import 'package:restoria/src/views/menu/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  await SoundEffects.init();
  BonfireInjector().put((i) => PlayerHeroController());
  BonfireInjector().putFactory((i) => GoblinController());
  BonfireInjector().put((i) => BarsController());
  BonfireInjector().put((i) => HeroMenuController());

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Normal'),
      home: const Menu(),
    ),
  );
}
