// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  State<Training> createState() => _Training();
}

class _Training extends State<Training> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'yM3n2mWZqUU', //https://youtu.be/yM3n2mWZqUU

      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.purple[100],
        progressColors: ProgressBarColors(
          playedColor: Colors.purple[100],
          handleColor: Colors.purple[100],
        ),
      ),
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text(" Training "),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Training",
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.grey[900],
                      fontFamily: "myfont",
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Cat training is the process of modifying a domestic cats behavior for entertainment or companionship purposes. Training is commonly used to reduce unwanted or problematic behaviors in domestic cats, to enhance interactions between humans and pet cats, and to allow them to coexist comfortably. There are various methods for training cats which employ different balances between reward and punishment",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'For more information, watch this video  :',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  player,
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
