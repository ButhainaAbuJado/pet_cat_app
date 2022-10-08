// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class catl extends StatefulWidget {
  const catl ({Key? key}) : super(key: key);

  @override
  State<catl > createState() => _catl ();
}

class _catl extends State<catl > {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'Xz6yBbBRr8Y', // https://youtu.be/Xz6yBbBRr8Y

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
              title: Text(" Cats Body Language "),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Cats Body Language",
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
                    "Nearly every pet owner has wondered what their furry friend is thinking. Animals can't use human speech to tell us what's on their minds, but they do have ways of communicating. You can tell a lot about what your pet is feeling by the position of their body.‌Cats are very expressive if you know what to look for in their body language. Everything from the way their tail twitches to the position of their ears is a form of communication. Learn more about how to read a cat's body language.When your cat is relaxed and happy, they might look sleepy or chilled out. Their muscles are loose and their head will be still instead of turning and looking around. A cat who seems relaxed and content might welcome some petting or snuggling.Ears. A relaxed cat's ears will be in a natural posture. They won't be flattened to the head or angled back. While their ears might twitch in response to a noise, they aren't swiveling constantly.Eyes. When your cat is relaxed, their pupils will be at their typical size. You may see them let their eyes close halfway as if the cat is about to doze off. They won't seem watchful or intent.Body. If your cat is lying down, they might be on their side, angled so their belly is showing. This is a sign that they feel safe. If the cat is sitting up, their back will be straight and their head up.Tail. A happy, relaxed cat will let their tail extend and lie flat. The tail will be fairly still, and the fur will lie flat against it.Playful When your cat wants to play, they'll show a lot of energy. They might start stalking you around the house as if encouraging you to join the game. They may start playing with a favorite toy.Ears. A playful cat will have their ears up. The ears will point forward, and you might think they look especially alert.Eyes. Your cat will watch you or a toy intently while playing. Their pupils will dilate, and they might get a wild look in their eyes.Body. Cats like to play stalking games. You may see the cat crouched with their hind end raised as if ready to pounce. Pouncing is another sign that your cat is feeling playful.Tail. Some cats will keep their tails down while getting ready to pounce. You might notice their tail raised and flicking around. Occasionally, a young cat or kitten might even chase their own tail.Scared or Worried A scared cat might start to resemble a Halloween cat with an arched back and raised tail. Your kitty might find a hiding place and refuse to come out. They may show their teeth or hiss. Your cat may show the following signs of being scared as well.Ears. Your cat may flick their ears back and forth rapidly so they can monitor sounds around them. They might draw their ears down so they point sideways or lie flat against their head.Eyes. A scared cat might look very watchful. Their eyes will be open and their pupils dilated.Body. Your cat might arch their back and let their fur stand on end. They may go into a crouched position as if they're about to run away. You'll be able to see that they're tense and ready for a fight-or-flight response.Tail. A frightened cat might hold their tail up and rigid. They might curl their tail around their body to protect it from being grabbed or bitten.",
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
