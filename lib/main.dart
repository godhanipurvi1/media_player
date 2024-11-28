import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song/provider/provide.dart';
import 'package:song/provider/videopro.dart';
import 'package:song/screen/audio.dart';
import 'package:song/screen/homepage.dart';
import 'package:song/screen/mainscren.dart';
import 'package:song/screen/video.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MediaProvider(),
      child: ChangeNotifierProvider(
        create: (context) => VideoProvider(),
        child: MaterialApp(
          home: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        'audio': (context) => AudioScreen(),
        'homepage': (context) => SongListPage(),
        'video': (context) => VideoPage(),
      },
    );
  }
}
