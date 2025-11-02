import 'dart:developer';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors, TextStyle;
import 'package:restoria/src/objects/map/map.dart';
import 'package:restoria/src/objects/util/sprite/common_sprite.dart';
import 'package:restoria/src/objects/util/sprite/enemy_sprite.dart';

import 'goblin_controller.dart';

class SimpleEnemyCounter extends SimpleEnemy {
  SimpleEnemyCounter({
    required super.position,
    required super.size,
    super.speed,
    super.life,
    super.animation,
  }) : super();

  @override
  void die() {
    final count = gameRef.livingEnemies().length;
    log('changeCountLiveEnemies $count');
    if (count == 0) {
      log('Level Cleared!');
      gameRef.overlays.add('LevelCompleted');
    }
    super.die();
  }
}

class Goblin extends SimpleEnemyCounter
    with
        AutomaticRandomMovement,
        UseStateController<GoblinController>,
        UseBarLife,
        BlockMovementCollision {
  Goblin(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(MainMap.tileSize * 0.8),
          speed: MainMap.tileSize * 1.6,
          life: 100,
        ) {
    // setupCollision(
    //   CollisionConfig(
    //     collisions: [
    //       CollisionArea.rectangle(
    //         size: Vector2(
    //           MainMap.tileSize * 0.4,
    //           MainMap.tileSize * 0.4,
    //         ),
    //         align: Vector2(
    //           MainMap.tileSize * 0.2,
    //           MainMap.tileSize * 0.2,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Future<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void die() {
    super.die();
    gameRef.add(
      AnimatedGameObject(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(MainMap.tileSize),
        loop: false,
      ),
    );
    removeFromParent();
  }

  void execAttack(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackMelee(
      size: Vector2.all(width),
      damage: damage / 2,
      interval: 400,
      sizePush: MainMap.tileSize / 2,
      animationRight: CommonSpriteSheet.blackAttackEffectRight,
    );
  }

  @override
  void removeLife(double life) {
    showDamage(
      life,
      config: TextStyle(
        fontSize: width / 3,
        color: Colors.white,
      ),
    );
    super.removeLife(life);
  }
}
