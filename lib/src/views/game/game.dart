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

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    startBgmGameMusic();
    Vector2 mouseVector = Vector2(0, 0);
    FocusNode gameFocus = FocusNode();

    updateMouseCoords(PointerEvent details) {
      final x = details.position.dx;
      final y = details.position.dy;
      mouseVector = Vector2(x, y);
    }

    Vector2 getMouseVector() => mouseVector;

    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          MainMap.tileSize = max(constraints.maxHeight, constraints.maxWidth) / (kIsWeb ? 25 : 22);

          return MouseRegion(
            onHover: updateMouseCoords,
            child: Focus(
            onFocusChange: (_) => gameFocus.requestFocus(),
              child: BonfireWidget(
                showCollisionArea: true,
                focusNode: gameFocus,
                joystick: Platform.isAndroid && Platform.isIOS
                    ? Joystick(
                        directional: JoystickDirectional(
                          spriteBackgroundDirectional: Sprite.load(
                            'joystick/joystick_background.png',
                          ),
                          spriteKnobDirectional: Sprite.load('joystick/joystick_knob.png'),
                          size: 100,
                          isFixed: false,
                        ),
                        actions: [
                          JoystickAction(
                            actionId: HeroAttackType.attackMelee,
                            sprite: Sprite.load('joystick/joystick_attack.png'),
                            align: JoystickActionAlign.BOTTOM_RIGHT,
                            size: 80,
                            margin: const EdgeInsets.only(bottom: 50, right: 50),
                          ),
                          JoystickAction(
                            actionId: HeroAttackType.attackRanged,
                            sprite: Sprite.load('joystick/joystick_attack_range.png'),
                            spriteBackgroundDirection: Sprite.load(
                              'joystick/joystick_background.png',
                            ),
                            enableDirection: true,
                            size: 50,
                            margin: const EdgeInsets.only(bottom: 50, right: 160),
                          )
                        ],
                      )
                    : Joystick(
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
                      ),
                player: PlayerHero(Vector2((8 * MainMap.tileSize), (5 * MainMap.tileSize)), getMouseVector),
                interface: PlayerHeroInterface(),
                map: WorldMapByTiled(
                  'tile/map.json',
                  forceTileSize: Vector2(MainMap.tileSize, MainMap.tileSize),
                  objectsBuilder: {
                    'Goblin': (properties) => Goblin(properties.position),
                  },
                ),
                overlayBuilderMap: {
                  'Bars': (context, game) => const Bars(),
                  'GameOver': (context, game) => const GameOver(),
                  'GameMenu': (context, game) => const GameMenu(),
                  'MiniMap': (context, game) => MiniMap(
                        game: game,
                        margin: const EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(10),
                        size: Vector2.all(
                          min(constraints.maxHeight, constraints.maxWidth) / 7,
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                      ),
                  'HeroMenu': (context, game) => const HeroMenu(),
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
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> startBgmGameMusic() async {
  FlameAudio.bgm.initialize();
  FlameAudio.bgm.stop();
  try {
    // await FlameAudio.bgm.play('music/bg_music.mp3', volume: 0.1);
  } on Exception catch (e) {
    // TODO
  }
}
