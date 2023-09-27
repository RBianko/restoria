import 'dart:math';
import 'dart:developer' as d;

import 'package:bonfire/bonfire.dart';
import 'package:restoria/src/objects/enemy/goblin.dart';

import '../../map/map.dart';

class RespawnManager {
  static late BonfireGame game;

  static double get _tileSize => MainMap.tileSize;

  static final Map<String, Duration> _respawnTimes = {
    EnemyType.goblin.name: const Duration(seconds: 1),
    EnemyType.orc.name: const Duration(seconds: 1),
    EnemyType.skeleton.name: const Duration(seconds: 1),
    EnemyType.slime.name: const Duration(seconds: 1),
    EnemyType.bat.name: const Duration(seconds: 1),
    EnemyType.spider.name: const Duration(seconds: 1),
  };

  static final Map<int, Map<EnemyType, int>> _respawnCountByLevel = {
    1: {
      EnemyType.goblin: 7,
    },
    2: {
      EnemyType.goblin: 14,
    },
    3: {
      EnemyType.goblin: 25,
    },
    4: {
      EnemyType.goblin: 25,
    },
    5: {
      EnemyType.goblin: 25,
    },
    6: {
      EnemyType.goblin: 25,
    },
  };

  static _createByType(EnemyType type, Vector2 position) {
    return switch (type) {
      EnemyType.goblin => Goblin(position),
      EnemyType.orc => Goblin(position),
      EnemyType.skeleton => Goblin(position),
      EnemyType.slime => Goblin(position),
      EnemyType.bat => Goblin(position),
      EnemyType.spider => Goblin(position),
    };
  }

  static Duration _getRespawnTime(EnemyType type) {
    return _respawnTimes[type.name]!;
  }

  static Vector2 _randomVector() {
    return Vector2(
        Random()
            .nextInt(
                (((game.size.x - _tileSize) + _tileSize) / _tileSize).floor())
            .toDouble(),
        Random()
            .nextInt(
                (((game.size.y - _tileSize) + _tileSize) / _tileSize).floor())
            .toDouble());
  }

  static List<TileModel> _calculateCollisions() {
    List<TileModel> collisionTiles = game.map.tiles
        .where((tile) => tile.collisions?.isNotEmpty ?? false)
        .toList();
    game.enemies().whereType<SimpleEnemy>().forEach((element) {
      collisionTiles.add(TileModel(
        x: (element.position.x / _tileSize).floor().toDouble(),
        y: (element.position.y / _tileSize).floor().toDouble(),
        width: _tileSize,
        height: _tileSize,
        collisions: [
          CollisionArea.rectangle(size: Vector2(_tileSize, _tileSize))
        ],
      ));
    });

    return collisionTiles;
  }

  static Vector2 _spawnPoint() {
    Vector2 point = _randomVector();
    List<TileModel> collisionTiles = _calculateCollisions();
    while (collisionTiles.where((tile) {
      if ((point.x >= tile.x && point.x <= tile.x) &&
          (point.y >= tile.y && point.y <= tile.y)) {
        return true;
      } else {
        return false;
      }
    }).isNotEmpty) {
      point = _randomVector();
    }

    return point;
  }

  static SimpleEnemy _spawn(EnemyType type) {
    final Vector2 point = _spawnPoint();
    d.log('_spawn: $type: [${point.x}, ${point.y}]');
    final SimpleEnemy enemy =
        _createByType(type, Vector2(point.x * _tileSize, point.y * _tileSize));

    return enemy;
  }

  static Future spawnEnemiesForLevel(int level) async {
    _respawnCountByLevel[level]!.forEach((type, count) {
      _startSpawnByType(
          EnemyType.values.firstWhere((enemy) => enemy == type), count);
    });
  }

  static void _startSpawnByType(EnemyType type, int enemiesCount) async {
    int count = enemiesCount;
    int gameHash = game.gameController!.gameRef.hashCode;

    while (count > 0) {
      await Future.delayed(_getRespawnTime(type)).then((_) {
        if (gameHash == game.gameController?.gameRef.hashCode) {
          d.log('_startSpawnByType: $gameHash: $type: [$count]');
          game.gameController?.addGameComponent(_spawn(type));
        } else {
          return;
        }
      });
      count--;
    }
  }
}

enum EnemyType {
  goblin,
  orc,
  skeleton,
  slime,
  bat,
  spider,
}
