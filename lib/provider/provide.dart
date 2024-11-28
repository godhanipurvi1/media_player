import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';

List<MediaItem> mediaItems = [
  MediaItem(
    title: "StudySong",
    type: "audio",
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    artist: "Artist 1",
    thumbnailUrl:
        "https://cdn.sanity.io/images/7g6d2cj1/production/81b67e7af332ce7e4b971bad24c892a114f06448-1000x667.jpg?h=667&q=70&auto=format", // Fallback to a default thumbnail if null
  ),
  MediaItem(
    title: "LofiSong",
    type: "audio",
    url:
        'https://pagalfree.com/music/singham-again-title-track-2024.html', // Network audio URL
    artist: "Artist 2",
    thumbnailUrl:
        "https://png.pngtree.com/png-clipart/20220530/original/pngtree-music-circle-wave-sound-beat-png-image_7757264.png", // Fallback to a default thumbnail if null
  ),
];

class MediaProvider extends ChangeNotifier {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  String currentTrackTitle = "";
  String currentTrackUrl = "";
  String currentTrackThumbnail = "";
  double currentPosition = 0.0;
  double totalDuration = 100.0; // Example total duration
  bool isPlaying = false;
  int currentIndex = 0;

  // Set the current media data (called when a new media item is selected)
  void setCurrentMedia(String title, String url, String thumbnail) {
    currentTrackTitle = title;
    currentTrackUrl = url;
    currentTrackThumbnail = thumbnail;
    notifyListeners();
  }

  // Initialize the audio player with the list of songs
  void init() {
    List<Audio> audioList = mediaItems.map(
      (e) {
        return Audio.network(
          e.url,
          metas: Metas(
            title: e.title,
          ),
        );
      },
    ).toList();

    _audioPlayer
        .open(
      Playlist(audios: audioList, startIndex: currentIndex),
      autoStart: false,
    )
        .then((_) {
      // After opening, initialize the first track's data
      final firstItem = mediaItems[currentIndex];
      setCurrentMedia(
        firstItem.title,
        firstItem.url,
        firstItem.thumbnailUrl ??
            "https://cdn.sanity.io/images/7g6d2cj1/production/81b67e7af332ce7e4b971bad24c892a114f06448-1000x667.jpg?h=667&q=70&auto=format", // Fallback to default thumbnail if null
      );
    });
    notifyListeners();
  }

  // Toggle play and pause functionality
  void togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  // Seek to a specific position in the track
  void seekTo(double position) {
    currentPosition = position;
    _audioPlayer.seek(Duration(seconds: position.toInt()));
    notifyListeners();
  }

  // Skip to the previous track
  void skipToPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      final previousItem = mediaItems[currentIndex];
      setCurrentMedia(
        previousItem.title,
        previousItem.url,
        previousItem.thumbnailUrl ??
            "https://cdn.sanity.io/images/7g6d2cj1/production/81b67e7af332ce7e4b971bad24c892a114f06448-1000x667.jpg?h=667&q=70&auto=format", // Fallback to default thumbnail if null
      );
      _audioPlayer.open(Audio.network(previousItem.url), autoStart: true);
      isPlaying = true;
    }
    notifyListeners();
  }

  // Skip to the next track
  void skipToNext() {
    if (currentIndex < mediaItems.length - 1) {
      currentIndex++;
      final nextItem = mediaItems[currentIndex];
      setCurrentMedia(
        nextItem.title,
        nextItem.url,
        nextItem.thumbnailUrl ??
            "https://cdn.sanity.io/images/7g6d2cj1/production/81b67e7af332ce7e4b971bad24c892a114f06448-1000x667.jpg?h=667&q=70&auto=format", // Fallback to default thumbnail if null
      );
      _audioPlayer.open(Audio.network(nextItem.url), autoStart: true);
      isPlaying = true;
    }
    notifyListeners();
  }

  // Dispose the audio player when no longer needed
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
