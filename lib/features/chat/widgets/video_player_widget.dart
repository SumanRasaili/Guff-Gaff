import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoPlayerWidget extends StatefulHookConsumerWidget {
  final String videoData;
  const VideoPlayerWidget({required this.videoData, super.key});

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  late CachedVideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.videoData)
          ..initialize().then((value) => videoPlayerController.setVolume(1));
  }

  @override
  Widget build(BuildContext context) {
    final isPlay = useState<bool>(false);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(children: [
        CachedVideoPlayer(videoPlayerController),
        Align(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () {
                if (isPlay.value) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
              },
              icon: const Icon(Icons.play_arrow)),
        )
      ]),
    );
  }
}
