import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/database_logic.dart';
import 'package:ars_corpia/objects/review.dart';
import 'package:ars_corpia/pages/view_marker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MarkerReviews extends StatefulWidget {
  const MarkerReviews({Key? key}) : super(key: key);

  @override
  State<MarkerReviews> createState() => _MarkerReviewsState();
}

class _MarkerReviewsState extends State<MarkerReviews> {
  late PlayerState _playerState;
  late YoutubeMetaData _youtubeMetaData;
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool isMute = false;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _youtubeMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _youtubeMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Markers' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder(builder: (context , snapshot) {
        if (snapshot.hasData) {
          Set<List<Review>> set = snapshot.data;
          List<Review> reviews = set.first;
          bool individualMute =  true;

          if (reviews.isEmpty) {
            return const Center(child: Text('There are no review based markers currently'),);
          }else{

            return ListView.builder(
                itemBuilder: (context , index) {
                  _controller = YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(
                      reviews[index].youtube ?? '',) ?? '',
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      mute: isMute
                    )
                  )..addListener(listener);
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                    shadowColor: shadowColor,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Youtube player
                        YoutubePlayerBuilder(
                            player: YoutubePlayer(
                                controller: _controller,
                              showVideoProgressIndicator: true,
                              progressColors: const ProgressBarColors(
                                playedColor: primaryProgessBar,
                                handleColor: primaryProgessBar
                              ),
                              onReady: () {
                                  _isPlayerReady = true;
                              },
                            ),
                            builder: (context , player){
                              return player;
                            },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // marker 1
                            Expanded(
                              child: Column(
                                children: [
                                  IconButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMarker(marker: reviews[index].markers[0])));
                                  }, icon: const FaIcon(FontAwesomeIcons.marker, color: iconColor,)),
                                  Text(reviews[index].markers[0].name , maxLines: 1, overflow: TextOverflow.ellipsis,)
                                ],
                              ),
                            ),
                            const Divider(),
                            // marker 2
                            Expanded(child: Column(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMarker(marker: reviews[index].markers[1])));
                                }, icon: const FaIcon(FontAwesomeIcons.marker, color: iconColor,)),
                                Text(reviews[index].markers[0].name , maxLines: 1, overflow: TextOverflow.ellipsis,)
                              ],
                            ),)
                          ],
                        ),
                        // go to video on youtube
                        Row(
                          children: [
                            Expanded(child: ElevatedButton(onPressed: () {
                              launchWebSiteUrl(reviews[index].youtube ?? '');
                            }, child: const FaIcon(FontAwesomeIcons.youtube)))
                          ],
                        )
                      ],
                    ),
                  );
                },
              itemCount: reviews.length,
            );
          }//end if-else
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }//end if-else
      },
        future: DatabaseLogic.getMarkerReviews(),),
    );
  }
}
