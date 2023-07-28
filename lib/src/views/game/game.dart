import 'dart:io';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restoria/src/objects/enemy/goblin.dart';
import 'package:restoria/src/objects/map/map.dart';
import 'package:restoria/src/objects/playerHero/player_hero.dart';
import 'package:restoria/src/objects/playerHero/player_hero_interface.dart';
import 'package:restoria/src/objects/util/interface/bars/HP/bars_ui.dart';
import 'package:restoria/src/objects/util/interface/menus/hero_menu_ui.dart';
import 'package:restoria/src/objects/util/interface/screens/game_menu.dart';
import 'package:restoria/src/objects/util/interface/screens/game_over.dart';
import 'package:restoria/src/objects/util/interface/screens/level_completed.dart';

import '../../objects/playerHero/player_hero_controller.dart';
import '../../objects/skills/skills.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with GameListener {
  final GameController _controller = GameController();
  int _level = 1;
  int _enemiesCount = 0;
  int _prevEnemiesCount = 0;

  @override
  void initState() {
    _controller.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    Vector2 mouseVector = Vector2(0, 0);
    FocusNode gameFocus = FocusNode();
    PlayerHeroController heroController =
        BonfireInjector().get<PlayerHeroController>();

    updateMouseCoords(PointerEvent details) {
      final x = details.position.dx;
      final y = details.position.dy;
      mouseVector = Vector2(x, y);
    }

    Vector2 getMouseVector() => mouseVector;

    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          MainMap.tileSize = max(constraints.maxHeight, constraints.maxWidth) /
              (kIsWeb ? 25 : 22);

          return MouseRegion(
            onHover: updateMouseCoords,
            child: Focus(
              onFocusChange: (_) => gameFocus.requestFocus(),
              child: BonfireWidget(
                gameController: _controller,
                showCollisionArea: true, // DebugMode
                focusNode: gameFocus,
                joystick: kIsWeb
                    ? Joystick(
                        keyboardConfig: KeyboardConfig(
                          keyboardDirectionalType: KeyboardDirectionalType.wasd,
                          acceptedKeys: [
                            LogicalKeyboardKey.space,
                            LogicalKeyboardKey.escape,
                            LogicalKeyboardKey.tab,
                            LogicalKeyboardKey.keyQ,
                            LogicalKeyboardKey.keyE,
                            LogicalKeyboardKey.keyR,
                          ],
                        ),
                      )
                    : Platform.isAndroid && Platform.isIOS
                        ? Joystick(
                            directional: JoystickDirectional(
                              spriteBackgroundDirectional: Sprite.load(
                                'joystick/joystick_background.png',
                              ),
                              spriteKnobDirectional:
                                  Sprite.load('joystick/joystick_knob.png'),
                              size: 100,
                              isFixed: false,
                            ),
                            actions: [
                              JoystickAction(
                                actionId: HeroAttackType.attackMelee,
                                sprite:
                                    Sprite.load('joystick/joystick_attack.png'),
                                align: JoystickActionAlign.BOTTOM_RIGHT,
                                size: 80,
                                margin: const EdgeInsets.only(
                                    bottom: 50, right: 50),
                              ),
                              JoystickAction(
                                actionId: HeroAttackType.attackRanged,
                                sprite: Sprite.load(
                                    'joystick/joystick_attack_range.png'),
                                spriteBackgroundDirection: Sprite.load(
                                  'joystick/joystick_background.png',
                                ),
                                enableDirection: true,
                                size: 50,
                                margin: const EdgeInsets.only(
                                    bottom: 50, right: 160),
                              )
                            ],
                          )
                        : Joystick(
                            keyboardConfig: KeyboardConfig(
                              keyboardDirectionalType:
                                  KeyboardDirectionalType.wasd,
                              acceptedKeys: [
                                LogicalKeyboardKey.space,
                                LogicalKeyboardKey.escape,
                                LogicalKeyboardKey.tab,
                                LogicalKeyboardKey.keyQ,
                                LogicalKeyboardKey.keyE,
                                LogicalKeyboardKey.keyR,
                              ],
                            ),
                          ),
                player: PlayerHero(
                    Vector2((8 * MainMap.tileSize), (5 * MainMap.tileSize)),
                    getMouseVector),
                interface: PlayerHeroInterface(),
                map: WorldMapByTiled(
                  'tile/map.json',
                  forceTileSize: Vector2(MainMap.tileSize, MainMap.tileSize),
                  objectsBuilder: {
                    // 'Goblin': (properties) => Goblin(properties.position),
                  },
                ),
                overlayBuilderMap: {
                  'Bars': (context, game) => const Bars(),
                  'GameOver': (context, game) => GameOver(startBgm),
                  'GameMenu': (context, game) => const GameMenu(),
                  'MiniMap': (context, game) => MiniMap(
                        game: game,
                        margin: const EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(10),
                        size: Vector2.all(
                          min(constraints.maxHeight, constraints.maxWidth) / 7,
                        ),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5)),
                      ),
                  'HeroMenu': (context, game) => const HeroMenu(),
                  'LevelCompleted': (context, game) =>
                      LevelCompleted(startBgm, _level - 1),
                },
                initialActiveOverlays: const [
                  'Bars',
                  'MiniMap',
                  'HeroMenu',
                ],
                cameraConfig: CameraConfig(
                  smoothCameraEnabled: true,
                  smoothCameraSpeed: 2,
                ),
                onReady: (BonfireGame game) async => await _onGameStart(
                    game, _controller, _level, heroController),
                onDispose: () async => await _onGameOver(heroController),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void changeCountLiveEnemies(int count) {
    print('changeCountLiveEnemies $count');
    if (_prevEnemiesCount > count) _enemiesCount--;
    _prevEnemiesCount = count;
    if (_enemiesCount == 0) {
      _onLevelCompleted();
    }
  }

  @override
  void updateGame() {}

  void _onLevelCompleted() {
    _controller.gameRef.overlayManager.add('LevelCompleted');
    print('Level $_level Cleared!');
    _level++;
  }

  Future _onGameStart(BonfireGame game, GameController controller, int level,
      PlayerHeroController heroController) async {
    print('_onGameStart: Level $level');
    await startBgm('game');
    double tile = MainMap.tileSize;
    Vector2 randomVector() => Vector2(
        Random().nextDouble() * (game.size.x - tile) + tile,
        Random().nextDouble() * (game.size.y - tile) + tile);
    SimpleEnemy goblin() => Goblin(randomVector());
    final Map<int, List> enemies = {
      1: [
        goblin(),
        goblin(),
        goblin(),
        goblin(),
      ],
      2: List.filled(8, goblin()),
      3: List.filled(12, goblin()),
    };

    _enemiesCount = enemies[level]!.length;

    for (SimpleEnemy enemy in enemies[level]!) {
      await Future.delayed(const Duration(seconds: 1));
      controller.addGameComponent(enemy);
    }
  }

  _onGameOver(PlayerHeroController heroController) async {
    heroController.skills = List.generate(15, (index) => Skill.none());
    print('_onGameOver');
    await startBgm('menu');
  }

  Future<void> startBgm(String type) async {
    Map<String, Function> musicManager = {
      'menu': () async =>
          await FlameAudio.bgm.play('music/bg_music.mp3', volume: 0.1),
      'game': () async =>
          await FlameAudio.bgm.play('music/bg_music.mp3', volume: 0.1),
      'gameOver': () async =>
          await FlameAudio.bgm.play('music/bg_music.mp3', volume: 0.1),
      'levelCompleted': () async =>
          await FlameAudio.bgm.play('music/bg_music.mp3', volume: 0.1),
    };
    try {
      await FlameAudio.bgm.stop();
      FlameAudio.bgm.dispose();
      await musicManager[type]!();
    } on Exception catch (e) {
      // print(e);
    }
  }
}
