import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  double _volume = 100;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'OrDB4jpA1g8',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hướng dẫn sử dụng'),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onReady: () {
              _isPlayerReady = true;
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Hướng dẫn sử dụng',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Video hướng dẫn sử dụng ứng dụng. Vui lòng xem video để hiểu rõ hơn về cách sử dụng.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  final currentPosition = _controller.value.position;
                  final newPosition = currentPosition - const Duration(seconds: 10);
                  _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
                },
              ),
              IconButton(
                icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _controller.value.isPlaying
                    ? _controller.pause
                    : _controller.play,
              ),
              IconButton(
                icon: Icon(Icons.forward_10),
                onPressed: () {
                  final currentPosition = _controller.value.position;
                  final newPosition = currentPosition + const Duration(seconds: 10);
                  _controller.seekTo(newPosition < _controller.metadata.duration ? newPosition : _controller.metadata.duration);
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _controller.seekTo(Duration.zero);
                  _controller.play();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.volume_down),
                onPressed: () {
                  setState(() {
                    _volume = (_volume - 10).clamp(0.0, 100.0);
                    _controller.setVolume(_volume.toInt());
                  });
                },
              ),
              Text('${_volume.toInt()}'),
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  setState(() {
                    _volume = (_volume + 10).clamp(0.0, 100.0);
                    _controller.setVolume(_volume.toInt());
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
