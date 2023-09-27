import 'dart:developer';

import 'package:flame_audio/flame_audio.dart';

class SoundEffects {
  static const bgmAsset = 'music/bg_music.mp3';
  static const gameMusicAsset = 'music/game_music.ogg';
  static late final List<Uri> assets;
  static AudioPlayer? player;

  static Future init() async {
    FlameAudio.audioCache.prefix = 'assets/audio/';
    assets = await FlameAudio.audioCache.loadAll([
      bgmAsset,
      gameMusicAsset,
    ]);
  }

  static startBgm(BgmType type) async {
    log('SoundEffects: startBgm: $type');
    try {
      if (player != null && player?.state == PlayerState.playing) {
        log('SoundEffects: already playing');
        await player!.stop();
        await player!.dispose();
      }
      player = switch (type) {
        BgmType.menu => await FlameAudio.loop(bgmAsset, volume: 0.2),
        BgmType.game => await FlameAudio.loop(gameMusicAsset, volume: 0.2),
        BgmType.gameOver => await FlameAudio.play(bgmAsset, volume: 0.2),
        BgmType.levelCompleted => await FlameAudio.play(gameMusicAsset, volume: 0.2),
      };
    } on AudioPlayerException catch (e, st) {
      log('$st, $e');
    }
  }
}

enum BgmType {
  menu,
  game,
  gameOver,
  levelCompleted,
}
