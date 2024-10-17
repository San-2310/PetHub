/*import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
      setState(() {}); // Update the state when initialization is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(), // Show loading indicator while initializing
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the controller when the widget is disposed
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}*/

import 'package:chewie/chewie.dart';
//import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/*class VideoPlayer extends StatefulWidget{
  const VideoPlayer({super.key,required this.videoUrl});

  final String videoUrl;

  State<VideoPlayer> createState(){
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer>
{
 /* _VideoPlayerState();
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_){
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {

      });
    });

    super.initState();
  }*/

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoUrl,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: YoutubePlayer(controller:_controller),
    );
  }
}*/

/*class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? 'default_video_id';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: YoutubePlayer(controller: _controller),
          ),

      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}*/

/*class VideoPlayer extends StatelessWidget {
  VideoPlayer({Key? key}) : super(key: key);

  final FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("Flutter Video Player"),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
      ),
    );
  }
}*/

class VideoPlayer extends StatelessWidget{
  VideoPlayer({super.key});

  Widget build(context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Column(
        children: [
          PlayerWidget()
        ],
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget{
  PlayerWidget({super.key});

  State<PlayerWidget> createState(){
    return _PlayerWidget();
  }
}

class _PlayerWidget extends State<PlayerWidget>
{
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isVideoInitialized= false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/ideos/butterfly.mp4'));
    chewieController = ChewieController(videoPlayerController: videoPlayerController);
    videoPlayerController.initialize();
    setState(() {
      isVideoInitialized = true;
    });
  }

  Widget build(context)
  {
    if(isVideoInitialized) {
      return AspectRatio(aspectRatio: videoPlayerController.value.aspectRatio,
        child: Chewie(controller: chewieController,),);
    }else{
      return const CircularProgressIndicator();
    }
  }
}