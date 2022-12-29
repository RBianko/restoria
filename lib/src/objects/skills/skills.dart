import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:restoria/src/objects/util/sprite/common_sprite.dart';

class Skill {
  String id;
  int level = 0;
  int tier = 0;
  String name = '';
  Color iconBackground = Colors.transparent;
  UniqueKey? uKey = UniqueKey();
  SkillStat skillStat = SkillStat(
      damage: 0,
      interval: 100,
      icon: 'icon',
      animation: CommonSpriteSheet.explosionAnimation,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      size: 0,
      speed: 0);

  Skill._(
      {required this.id,
      required this.level,
      required this.tier,
      required this.name,
      required this.iconBackground,
      this.uKey,
      required this.skillStat});

  factory Skill({
    required String id,
    required int level,
  }) {
    return Skill._(
      id: id,
      level: level,
      name: skillsName[id]!,
      tier: skillsTier[id]!,
      skillStat: skillsData[id]!,
      uKey: UniqueKey(),
      iconBackground: _getIconBackground(skillsTier[id]!),
    );
  }

  Skill.none({this.id = 'None', level, tier, name, iconBackground, skillStat});
}

class SkillsId {
  static String fireball = 'FIREBALL';
  static String iceLance = 'ICELANCE';
  static String iceAndFire = 'ICEANDFIRE';
  static String hurricane = 'HURRICANE';
}

Map<String, String> skillsName = {
  SkillsId.fireball: 'Fireball',
  SkillsId.iceLance: 'Ice Lance',
  SkillsId.iceAndFire: 'Ice And Fire',
  SkillsId.hurricane: 'Hurricane',
};

Map<String, int> skillsTier = {
  SkillsId.fireball: 1,
  SkillsId.iceLance: 2,
  SkillsId.iceAndFire: 2,
  SkillsId.hurricane: 1,
};

Map<String, SkillStat> skillsData = {
  SkillsId.fireball: SkillStat(
      damage: 50,
      interval: 950,
      icon: '',
      animation: CommonSpriteSheet.fireBallRight,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      size: 0.7,
      speed: 190),
  SkillsId.iceLance: SkillStat(
      damage: 50,
      interval: 950,
      icon: '',
      animation: CommonSpriteSheet.fireBallRight,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      size: 0.7,
      speed: 190),
  SkillsId.iceAndFire: SkillStat(
      damage: 50,
      interval: 950,
      icon: '',
      animation: CommonSpriteSheet.fireBallRight,
      animationDestroy: CommonSpriteSheet.explosionAnimation,
      size: 0.7,
      speed: 190),
  SkillsId.hurricane: SkillStat(
      damage: 30,
      interval: 660,
      icon: '',
      animation: CommonSpriteSheet.whiteAttackEffectRight,
      animationDestroy: CommonSpriteSheet.smokeExplosion,
      size: 0.7,
      speed: 190),
};

class SkillStat {
  double damage;
  int interval;
  String icon;
  Future<SpriteAnimation> animation;
  Future<SpriteAnimation> animationDestroy;
  double size;
  double speed;

  SkillStat({
    required this.damage,
    required this.interval,
    required this.icon,
    required this.animation,
    required this.animationDestroy,
    required this.size,
    required this.speed,
  });
}

Color _getIconBackground(int tier) {
  int alfa = 190;
  switch (tier) {
    case 1:
      return (Colors.white70).withAlpha(alfa);
    case 2:
      return (Colors.blueAccent).withAlpha(alfa);
    case 3:
      return (Colors.deepPurpleAccent).withAlpha(alfa);
    case 4:
      return (Colors.yellowAccent).withAlpha(alfa);
    default:
      return (Colors.white70).withAlpha(alfa);
  }
}
