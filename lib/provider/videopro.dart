import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  VideoPlayerController get controller => _controller;
  ChewieController get chewieController => _chewieController;

  // Initialize video player controllers (from asset or network)
  void initializeVideoPlayer(String videoUrl) {
    _controller = VideoPlayerController.asset(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
        );
        notifyListeners();
      });
  }

  // Dispose controllers when not needed anymore
  void disposeControllers() {
    _controller.dispose();
    _chewieController.dispose();
  }
}
