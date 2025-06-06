import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    // Use low‐latency mode for short SFX
    _fxPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _fxPlayer = AudioPlayer();

  // AudioCache with a prefix pointing at your package’s assets
  final AudioCache _cache = AudioCache(prefix: 'packages/sky_hopper_game/assets/audio/');

  // Keep track of local file paths after preload
  final Map<String, String> _cachedFiles = {};

  // Flag to know if we’ve already preloaded everything
  bool _didPreload = false;

  /// Internal helper: copies each asset into a temp file once.
  Future<void> _ensurePreloaded() async {
    if (_didPreload) return;

    _cachedFiles['background.wav'] = await _cache.loadPath('background.wav');
    _cachedFiles['background02.flac'] = await _cache.loadPath('background02.flac');

    _cachedFiles['jump.wav'] = await _cache.loadPath('jump.wav');
    _cachedFiles['game_over.wav'] = await _cache.loadPath('game_over.wav');
    _cachedFiles['tick.wav'] = await _cache.loadPath('tick.wav');

    _didPreload = true;
  }

  /// Plays looping background music (automatically preloads on first call).
  Future<void> playBackgroundMusic({int track = 1}) async {
    // 1) Make sure all files are cached at least once
    await _ensurePreloaded();

    // 2) Configure looping and volume
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.setVolume(0.4);

    // 3) Pick the right file and play from its cached path
    final key = (track == 2) ? 'background02.flac' : 'background.wav';
    final path = _cachedFiles[key]!;

    await _bgmPlayer.play(DeviceFileSource(path));
  }

  /// Stops background music.
  Future<void> stopBackgroundMusic() async {
    await _bgmPlayer.stop();
  }

  /// Plays the “jump” SFX (auto‐preloads first).
  Future<void> playJump() async {
    await _ensurePreloaded();
    final path = _cachedFiles['jump.wav']!;
    await _fxPlayer.play(DeviceFileSource(path), volume: 1.0);
  }

  /// Plays the “game over” SFX (auto‐preloads first).
  Future<void> playGameOver() async {
    await _ensurePreloaded();
    final path = _cachedFiles['game_over.wav']!;
    await _fxPlayer.play(DeviceFileSource(path), volume: 1.0);
  }

  /// Plays the “point” (tick) SFX (auto‐preloads first).
  Future<void> playPoint() async {
    await _ensurePreloaded();
    final path = _cachedFiles['tick.wav']!;
    await _fxPlayer.play(DeviceFileSource(path), volume: 0.8);
  }
}
