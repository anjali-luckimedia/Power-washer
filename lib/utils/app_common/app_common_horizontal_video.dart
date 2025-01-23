import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HorizontalVideoList extends StatefulWidget {
  @override
  _HorizontalVideoListState createState() => _HorizontalVideoListState();
}

class _HorizontalVideoListState extends State<HorizontalVideoList> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

   List<VideoPlayerController>? _controllers;

  @override
  void initState() {
    super.initState();
    // print(_controllers!.length);
    // Initialize controllers and play them
    _controllers = videoUrls
        .map((url) => VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {}); // Rebuild when initialized
        _startAllVideos(); // Start playing all videos
      }))
        .toList();
  }

  // Start all videos simultaneously
  void _startAllVideos() {
    for (var controller in _controllers!) {
      controller.play();
      controller.setVolume(0.0);
      controller.setLooping(true);
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videoUrls.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: VideoItem(controller: _controllers![index]),
        );
      },
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoPlayerController controller;

  VideoItem({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
