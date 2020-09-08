import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerUI extends StatefulWidget{
  final String url;
  VideoPlayerUI(this.url);
  @override
  State<StatefulWidget> createState() {
    return VideoPlayerUIState();
  }
}

class VideoPlayerUIState extends State<VideoPlayerUI>{
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState(){
    _controller = VideoPlayerController.network(
      widget.url,
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the VideoPlayer.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        opacityButton(),
      ],
    );
  }
  Widget opacityButton(){
    var a;
    if(_controller.value.isPlaying){a = 0.0;}
    else{a = 1.0;}
    return Opacity(
        opacity: a,
      child:FloatingActionButton(
        backgroundColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child:
          Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
      ),
    );
  }
}