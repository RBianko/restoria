import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:restoria/src/objects/map/map.dart';

import 'goblin.dart';

///
/// Created by
///
/// ─▄▀─▄▀
/// ──▀──▀
/// █▀▀▀▀▀█▄
/// █░░░░░█─█
/// ▀▄▄▄▄▄▀▀
///
/// Rafaelbarbosatec
/// on 03/03/22

class GoblinController extends StateController<Goblin> {
  double attack = 20;
  bool _seePlayerToAttackMelee = false;
  bool enableBehaviors = true;

  @override
  void update(double dt, Goblin component) async {
    if (!enableBehaviors) return;

    if (!gameRef.sceneBuilderStatus.isRunning) {
      _seePlayerToAttackMelee = true;
      late int aiStupidity = Random().nextInt(10);
      if (aiStupidity > 6) return;

      component.seeAndMoveToPlayer(
        runOnlyVisibleInScreen: false,
        closePlayer: (player) {
          component.execAttack(attack);
        },
        observed: () {
          _seePlayerToAttackMelee = true;
        },
        radiusVision: MainMap.tileSize * 20,
      );

      if (!_seePlayerToAttackMelee) {
        component.seeAndMoveToAttackRange(
          minDistanceFromPlayer: MainMap.tileSize * 2,
          positioned: (p) {
            component.execAttackRange(attack);
          },
          radiusVision: MainMap.tileSize * 3,
          notObserved: () {
            component.runRandomMovement(
              dt,
              speed: component.speed / 2,
              maxDistance: (MainMap.tileSize * 3).toInt(),
            );
          },
        );
      }
    }
  }
}
