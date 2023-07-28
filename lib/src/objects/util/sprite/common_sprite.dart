import 'package:bonfire/bonfire.dart';

class CommonSpriteSheet {
  static Future<SpriteAnimation> get explosionAnimation => SpriteAnimation.load(
        "hero/explosion_fire.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> get smokeExplosion => SpriteAnimation.load(
        "sfx/smoke_explosion.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get whiteAttackEffectBottom =>
      SpriteAnimation.load(
        "hero/attack_effect_bottom.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get whiteAttackEffectLeft =>
      SpriteAnimation.load(
        "hero/attack_effect_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get whiteAttackEffectRight =>
      SpriteAnimation.load(
        "hero/attack_effect_right.png",
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get whiteAttackEffectTop =>
      SpriteAnimation.load(
        "hero/attack_effect_top.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get blackAttackEffectBottom =>
      SpriteAnimation.load(
        "enemy/attack_effect_bottom.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get blackAttackEffectLeft =>
      SpriteAnimation.load(
        "enemy/attack_effect_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get blackAttackEffectRight =>
      SpriteAnimation.load(
        "enemy/attack_effect_right.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get blackAttackEffectTop =>
      SpriteAnimation.load(
        "enemy/attack_effect_top.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get fireBallRight => SpriteAnimation.load(
        "hero/fireball_right.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallLeft => SpriteAnimation.load(
        "hero/fireball_left.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallBottom => SpriteAnimation.load(
        "hero/fireball_bottom.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallTop => SpriteAnimation.load(
        "hero/fireball_top.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get chestAnimated => SpriteAnimation.load(
        "items/chest_sprite.png",
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<Sprite> get potionLifeSprite =>
      Sprite.load('items/potion_life.png');
}
