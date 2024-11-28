import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../provider/provide.dart'; // Your MediaProvider file

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  void initState() {
    super.initState();
    final song = ModalRoute.of(context)?.settings.arguments
        as MediaItem; // Assuming Song is your model

    if (song != null) {
      final mediaProvider = Provider.of<MediaProvider>(context, listen: false);
      mediaProvider.setCurrentMedia(song.title, song.url, song.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaProvider = Provider.of<MediaProvider>(context);
    final song = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Album Art
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        mediaProvider.currentTrackThumbnail,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Song Title
                Text(
                  mediaProvider.currentTrackTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                // Progress Bar
                Slider(
                  value: mediaProvider.currentPosition,
                  max: mediaProvider.totalDuration,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.white24,
                  onChanged: (value) {
                    mediaProvider.seekTo(value);
                  },
                ),

                // Progress Times
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Duration(seconds: mediaProvider.currentPosition.toInt())
                            .toString()
                            .split('.')
                            .first,
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        Duration(seconds: mediaProvider.totalDuration.toInt())
                            .toString()
                            .split('.')
                            .first,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Media Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip to Previous Button
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white),
                  iconSize: 36,
                  onPressed: () => mediaProvider.skipToPrevious(),
                ),

                // Play/Pause Button
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple,
                  child: IconButton(
                    icon: Icon(
                      mediaProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    iconSize: 36,
                    onPressed: () {
                      mediaProvider.togglePlayPause();
                    },
                  ),
                ),

                // Skip to Next Button
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white),
                  iconSize: 36,
                  onPressed: () => mediaProvider.skipToNext(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
