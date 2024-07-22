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
  Duration _videoPosition = Duration.zero;
  Duration _videoDuration = Duration.zero;


  final Map<String, String> _videoMap = {
    'OrDB4jpA1g8': 'Hướng dẫn đăng nhập-đăng ký', 
    '_VuJA-VQRcY': 'Hướng dẫn app',
    'pDddlvCfTiw': 'Nhạc',
  };
  String _currentVideoId = 'OrDB4jpA1g8'; 

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _currentVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _videoPosition = _controller.value.position;
        _videoDuration = _controller.metadata.duration;
      });
    }
  }

  void _changeVideo(String videoId) {
    setState(() {
      _currentVideoId = videoId;
      _controller.load(_currentVideoId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hướng dẫn sử dụng'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _currentVideoId,
            onChanged: (String? newValue) {
              if (newValue != null) {
                _changeVideo(newValue);
              }
            },
            items: _videoMap.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onReady: () {
              _isPlayerReady = true;
              setState(() {
                _videoDuration = _controller.metadata.duration;
              });
            },
          ),
          const SizedBox(height: 10),
          if (_videoDuration != Duration.zero)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_videoPosition)),
                      Text(_formatDuration(_videoDuration)),
                    ],
                  ),
                  Slider(
                    value: _videoPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: _videoDuration.inSeconds.toDouble(),
                    onChanged: (newValue) {
                      _controller.seekTo(Duration(seconds: newValue.toInt()));
                    },
                    divisions: _videoDuration.inSeconds,
                    label: '${_formatDuration(_videoPosition)} / ${_formatDuration(_videoDuration)}',
                  ),
                ],
              ),
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
                  _controller.seekTo(newPosition < _videoDuration ? newPosition : _videoDuration);
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
