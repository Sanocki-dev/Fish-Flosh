import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'game.dart';

/**
 * GameOverScreen Stateful Setup
 */
class GameOverScreen extends StatefulWidget {
  // What is required to be sent to this page
  GameOverScreen(
      {Key key, this.title, @required this.isNewScore, this.newScore})
      : super(key: key);
  
  // Variables used on this page
  final String title;
  final bool isNewScore;
  final int newScore;

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

/**
 * Linear gradient created for the on screen text 
 */
final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color.fromRGBO(255, 224, 0, 1),
    Color.fromRGBO(255, 100, 0, 1)
  ],
).createShader(Rect.fromLTWH(100.0, 200.0, 100.0, 200.0));

/**
 * GameOverScreen Logic and Layout
 */
class _GameOverScreenState extends State<GameOverScreen> {
  // Variables
  String _scoreText = "";
  bool isFading = true;
  Timer _pulse;

  // When the screen is loaded the init state will start a timer
  @override
  void initState() {
    _pulse = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      // Checks to see if the text is currently visiable
      if (mounted) {
        setState(() {
          // Reverse fading cycle
          isFading = !isFading;
        });
      }
    });

    // Checks if the player has a new high score
    if (widget.isNewScore)
      _scoreText = "new HIGH SCORE\n" + widget.newScore.toString();

    // Returns to the main screen 
    returnToMain();
    super.initState();
  }

  // Function will wait 5 seconds before sending the player back to the main screen
  void returnToMain() async {
    await new Future.delayed(const Duration(seconds: 5));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  // Disposes of the timers and page
  @override
  void dispose() {
    _pulse.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'GAME\nOVER',
                  style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 3),
                      )
                    ],
                    fontSize: 130,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.topCenter,
                child: AnimatedOpacity(
                  // Handles the fading in and out of the text
                  opacity: isFading ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 1000),
                  child: Text(
                    '$_scoreText',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                        )
                      ],
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
