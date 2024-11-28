import 'package:flutter/material.dart';
import 'package:song/screen/video.dart';

import 'audio.dart';
import 'homepage.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Media Booster"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.music_note), text: "Audio"),
              Tab(icon: Icon(Icons.video_library), text: "Video"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SongListPage(),
            VideoPage(),
          ],
        ),
      ),
    );
  }
}
