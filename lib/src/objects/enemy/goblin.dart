import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors, TextStyle;
import 'package:restoria/src/objects/map/map.dart';
import 'package:restoria/src/objects/util/sprite/common_sprite.dart';
import 'package:restoria/src/objects/util/sprite/enemy_sprite.dart';

import 'goblin_controller.dart';

class Goblin extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement, UseStateController<GoblinController>, UseBarLife {
  Goblin(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(MainMap.tileSize * 0.8),
          speed: MainMap.tileSize * 1.6,
          life: 100,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              MainMap.tileSize * 0.4,
              MainMap.tileSize * 0.4,
            ),
            align: Vector2(
              MainMap.tileSize * 0.2,
              MainMap.tileSize * 0.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void die() {
    super.die();
    gameRef.add(
      AnimatedObjectOnce(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(MainMap.tileSize),
      ),
    );
    removeFromParent();
  }

  void execAttackRange(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    simpleAttackRange(
      animationRight: CommonSpriteSheet.fireBallRight,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      id: 35,
      size: Vector2.all(width * 0.9),
      damage: damage,
      speed: MainMap.tileSize * 3,
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2.all(width / 2),
            align: Vector2(width * 0.25, width * 0.25),
          ),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: width / 2,
        blurBorder: width,
        color: Colors.orange.withOpacity(0.3),
      ),
    );
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
