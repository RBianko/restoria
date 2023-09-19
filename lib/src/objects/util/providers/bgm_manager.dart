import 'package:flame_audio/flame_audio.dart';

class SoundEffects {
  static AudioPlayer player = AudioPlayer();
  static final bgmAsset = AssetSource('audio/music/bg_music.mp3');
  static final gameMusicAsset = AssetSource('audio/music/game_music.ogg');

  static Future<void> startBgm(BgmType type) async {
    await player.setReleaseMode(ReleaseMode.release);

    try {
      if (player.state == PlayerState.playing) {
        await player.stop();
        await player.release();
      }
      return switch (type) {
        BgmType.menu => await player.play(bgmAsset),
        BgmType.game => await player.play(gameMusicAsset),
        BgmType.gameOver => await player.play(bgmAsset),
        BgmType.levelCompleted => await player.play(bgmAsset),
      };
    } on AudioPlayerException catch (e, st) {
      print('$st, $e');
    }
  }
}

enum BgmType {
  menu,
  game,
  gameOver,
  levelCompleted,
}
