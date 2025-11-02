import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:restoria/src/objects/map/map.dart';

import 'goblin.dart';

/// Rafaelbarbosatec

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
    }
  }
}
