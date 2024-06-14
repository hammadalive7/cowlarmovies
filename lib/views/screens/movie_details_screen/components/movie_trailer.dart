import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../controllers/movie_details_controller.dart';
import '../../../../helpers/process_image_link.dart';
import '../../../../models/movie_model.dart';

class MovieTrailer extends StatefulWidget {

  final String movieID;
  final Movie movie;

  const MovieTrailer({
    super.key,
    required this.movieID,
    required this.movie
  });


  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late YoutubePlayerController _controller;
  final controller = Get.find<MovieDetailsController>();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: controller.trailerYouTubeID.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([controller.getMovieTrailer(widget.movieID)]),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            // height: MediaQuery.of(context).size.height * 0.5,
            child: GestureDetector(
              onTap: () async {
                if (controller.trailerYouTubeID.value == '') {
                  const snackBar = SnackBar(
                    content: Text('Movie trailer not available', style: TextStyle(color: Colors.white),),
                    backgroundColor: CupertinoColors.secondaryLabel,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  showMovieTrailerDialog(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                        Image.network(
                          ProcessImage.processPosterLink(
                            widget.movie.backdropPath ?? widget.movie.posterPath,
                          ),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,

                        ),
                      ),
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showMovieTrailerDialog(BuildContext context) {
    _controller = YoutubePlayerController(
      initialVideoId: controller.trailerYouTubeID.value,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,

      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          content: YoutubePlayer(
            controller: _controller,

            showVideoProgressIndicator: true,
            onReady: () => debugPrint('Ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Colors.orange,
                  handleColor: Colors.orangeAccent,
                ),
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
