import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:restoria/src/objects/map/map.dart';
import 'package:restoria/src/objects/skills/skills.dart';
import 'package:restoria/src/objects/util/interface/bars/HP/bars_controller.dart';
import 'package:restoria/src/objects/util/sprite/common_sprite.dart';
import 'package:restoria/src/objects/util/sprite/hero_sprite.dart';

import 'player_hero_controller.dart';

enum HeroAttackType { attackMelee, attackRanged }

class PlayerHero extends SimplePlayer
    with Lighting, ObjectCollision, UseStateController<PlayerHeroController> {
  static final double maxSpeed = MainMap.tileSize * 2.5;

  double angleRadAttack = 0.0;
  Rect? rectDirectionAttack;
  Sprite? spriteDirectionAttack;
  bool showBgRangeAttack = false;
  Function getMouseVector;

  BarsController? barLifeController;

  PlayerHero(Vector2 position, this.getMouseVector)
      : super(
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          size: Vector2.all(MainMap.tileSize + 7),
          position: position,
          life: 200,
          speed: maxSpeed,
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width * 1.5,
        color: Colors.transparent,
      ),
    );
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(width / 5.0, width / 5.0),
            align: Vector2(
              width / 2.5,
              width / 2.5,
            ),
          )
        ],
      ),
    );
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) {
      return;
    }
    speed = maxSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) {
      return;
    }
    if (hasController) {
      controller.handleJoystickAction(event);
    }
    super.joystickAction(event);
  }

  double getMouseAngle() {
    final Vector2 mouseVector = getMouseVector();
    final Vector2 fixedPosition = position + size / 2;

    final mouseVectorToWorld = gameRef.screenToWorld(mouseVector);
    return BonfireUtil.angleBetweenPoints(fixedPosition, mouseVectorToWorld);
  }

  void execMeleeAttack(double attack) {
    simpleAttackMelee(
      damage: attack,
      animationRight: CommonSpriteSheet.whiteAttackEffectRight,
      size: Vector2.all(MainMap.tileSize),
    );
  }

  void executeSkill(Skill skill) {
    simpleAttackRangeByAngle(
      attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
      animation: skill.skillStat.animation,
      animationDestroy: skill.skillStat.animationDestroy,
      angle: getMouseAngle(),
      size: Vector2.all(width * skill.skillStat.size),
      damage: skill.skillStat.damage,
      speed: skill.skillStat.speed,
      collision: CollisionConfig(
        enable: false,
        collisions: [
          CollisionArea.polygon(
            points: [
              Vector2(0, 30),
              Vector2(5, 15),
              Vector2(0, 0),
              Vector2(15, 15),
            ],
            align: Vector2(width * 0.3, width * 0.1),
          )
        ],
      ),
      destroySize: Vector2(width / 12, width / 12),
      marginFromOrigin: 25,
    );
  }

  @override
  void update(double dt) {
    barLifeController?.life = life;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _drawDirectionAttack(canvas);
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (attacker == AttackFromEnum.PLAYER_OR_ALLY) return;
    if (hasController) {
      controller.onReceiveDamage(damage);
    }
    super.receiveDamage(attacker, damage, identify);
  }

  void _drawDirectionAttack(Canvas canvas) {
    if (showBgRangeAttack) {
      double radius = height;
      rectDirectionAttack = Rect.fromLTWH(
        rectCollision.center.dx - radius,
        rectCollision.center.dy - radius,
        radius * 2,
        radius * 2,
      );

      if (rectDirectionAttack != null && spriteDirectionAttack != null) {
        renderSpriteByRadAngle(
          canvas,
          angleRadAttack,
          rectDirectionAttack!,
          spriteDirectionAttack!,
        );
      }
    }
  }

  @override
  Future<void> onLoad() async {
    spriteDirectionAttack = await Sprite.load('hero/direction_attack.png');
    return super.onLoad();
  }

  @override
  void onMount() {
    barLifeController = BonfireInjector().get<BarsController>();
    barLifeController?.configure(maxLife: maxLife, maxStamina: 100);
    super.onMount();
  }

  void execEnableBGRangeAttack(bool enabled, double angle) {
    showBgRangeAttack = enabled;
    angleRadAttack = angle;
  }

  void execShowDamage(double damage) {
    showDamage(
      damage,
      config: TextStyle(
        fontSize: width / 3,
        color: Colors.red,
      ),
    );
  }

  void updateStamina(double stamina) {
    barLifeController?.stamina = stamina;
  }

  @override
  void die() {
    removeFromParent();
    gameRef.overlayManager.add('GameOver');
    gameRef.colorFilter?.animateTo(Colors.red.withOpacity(0.5));
    gameRef.add(
      GameDecoration.withSprite(
        sprite: Sprite.load('hero/crypt.png'),
        position: position,
        size: Vector2.all(MainMap.tileSize),
      ),
    );
    super.die();
  }
}
