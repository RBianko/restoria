import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "hero/boris/idle.png",
        SpriteAnimationData.sequenced(
          amountPerRow: 1,
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
          texturePosition: Vector2(30, 0),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "hero/boris/run.png",
        SpriteAnimationData.sequenced(
          amountPerRow: 1,
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
          texturePosition: Vector2(30, 0),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}
