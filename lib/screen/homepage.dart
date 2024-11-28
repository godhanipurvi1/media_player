import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provide.dart';

class SongListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Songs List"),
      ),
      body: ListView.builder(
        itemCount: mediaItems.length, // Number of media items
        itemBuilder: (context, index) {
          final song = mediaItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(song.url), // Song thumbnail
            ),
            title: Text(
              song.title, // Song title
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(song.artist),
            onTap: () {
              // Set the selected media in the provider
              final mediaProvider =
                  Provider.of<MediaProvider>(context, listen: false);
              mediaProvider.setCurrentMedia(song.title, song.url, song.url);

              // Navigate to the audio page and pass the song as an argument
              Navigator.pushNamed(
                context,
                'audio',
                arguments: song, // Passing the current song as an argument
              );
            },
          );
        },
      ),
    );
  }
}
