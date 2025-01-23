/*
import 'package:flutter/material.dart';
import 'package:multi_video_player/multi_video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Ensure the list is of type List<String>
  List<dynamic> videos = [
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: Container(

              height: 100, // Set a fixed height for each video widget
              child: MultiVideoPlayer.network(
                videoSourceList: [videos[index]],
                height: 300,
                width: double.infinity,
                preloadPagesCount: videos.length,
                onPageChanged: (videoPlayerController, index) {
                  // Ensure the widget is mounted before calling setState
                  if (mounted) {
                    setState(() {});
                  }
                },
                getCurrentVideoController: (videoPlayerController) {},
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> videos = [
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ];

  List<VideoPlayerController> _controllers = [];
  VideoPlayerController? controller;
  @override
  void initState() {
    super.initState();

    // Initialize controllers for each video
    for (String videoUrl in videos) {
       controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {}); // Update UI after initialization
          controller!.play(); // Start playing the video
          controller!.setLooping(true); // Set looping if required
        });
      _controllers.add(controller!);
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200, // Set a fixed height for each video
              child: controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
                  : const Center(child: CircularProgressIndicator()), // Show loading while initializing
            ),
          );
        },
      ),
    );
  }
}
