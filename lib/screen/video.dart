// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
//
// import '../provider/provide.dart';
//
// class VideoScreen extends StatefulWidget {
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   VideoPlayerController? _controller;
//
//   @override
//   // void didChangeDependencies() {
//   //   super.didChangeDependencies();
//   //   final mediaProvider = Provider.of<MediaProvider>(context, listen: false);
//   //   if (mediaProvider.currentMedia != null &&
//   //       mediaProvider.currentMedia!.type == "video" &&
//   //       mediaProvider.currentMedia!.url != null) {
//   //     _controller?.dispose();
//   //
//   //     _controller =
//   //         VideoPlayerController.network(mediaProvider.currentMedia!.url!)
//   //           ..initialize().then((_) {
//   //             setState(() {}); // Trigger a rebuild when initialized
//   //             _controller!.play(); // Start playback
//   //           });
//   //   } else {
//   //     // Handle cases where currentMedia or url is null
//   //     _controller?.dispose();
//   //     _controller = null; // Clear the controller
//   //   }
//   // }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaProvider = Provider.of<MediaProvider>(context);
//
//     // return Column(
//     //   children: [
//     //     Expanded(
//     //       child: ListView.builder(
//     //         itemCount: mediaProvider.mediaItems
//     //             .where((item) => item.type == "video")
//     //             .length,
//     //         itemBuilder: (context, index) {
//     //           final videoItems = mediaProvider.mediaItems
//     //               .where((item) => item.type == "video")
//     //               .toList();
//     //           final media = videoItems[index];
//     //
//     //           return ListTile(
//     //             title: Text(media.title ?? "untitle"),
//     //             onTap: () {
//     //               mediaProvider.selectMedia(media);
//     //               setState(() {});
//     //             },
//     //           );
//     //         },
//     //       ),
//     //     ),
//     //     if (_controller != null && _controller!.value.isInitialized)
//     //       AspectRatio(
//     //         aspectRatio: _controller!.value.aspectRatio,
//     //         child: VideoPlayer(_controller!),
//     //       ),
//     //     if (_controller != null)
//     //       Row(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           IconButton(
//     //             icon: Icon(Icons.play_arrow),
//     //             onPressed: () => _controller!.play(),
//     //           ),
//     //           IconButton(
//     //             icon: Icon(Icons.pause),
//     //             onPressed: () => _controller!.pause(),
//     //           ),
//     //           IconButton(
//     //             icon: Icon(Icons.stop),
//     //             onPressed: () {
//     //               _controller!.pause();
//     //               _controller!.seekTo(Duration.zero);
//     //             },
//     //           ),
//     //         ],
//     //       ),
//     //   ],
//     // );
//   }
//}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';

import '../provider/videopro.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the video player when the page is first created
    Provider.of<VideoProvider>(context, listen: false)
        .initializeVideoPlayer('lib/assets/media/13.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          if (!videoProvider.controller.value.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: AspectRatio(
              aspectRatio: videoProvider.controller.value.aspectRatio,
              child: Chewie(controller: videoProvider.chewieController),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<VideoProvider>(context, listen: false).disposeControllers();
    super.dispose();
  }
}
