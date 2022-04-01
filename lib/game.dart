import 'dart:io';

import 'package:final_app/game_over.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'gamesettings.dart' as setting;

import 'dart:async';
import 'dart:math';

/**
 * GameScreen Stateful Setup
 */
class GameScreen extends StatefulWidget {
  final Storage storage;
  // What is required to be sent to this page
  GameScreen({Key key, @required this.storage}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

/**
 * GameOverScreen Logic and Layout
 */
class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  // Customization Variables
  String theme = setting.theme;
  String fishType = setting.fish;

  // Score Variables
  int _currentScore = 0;
  int _highScore = 0;
  bool isNewHigh = false;

  // Location Variables
  int _fish = 1;
  double _xAxis = 260;
  Random _rnd = new Random();

  // Arrays to hold the default location and size of the rod
  var _yAxis = [-100.0, -300.0, -500.0, -700.0, -900.0];
  var _rWidth = [0.0, 0.0, 0.0, 0.0, 0.0];
  var _lWidth = [0.0, 0.0, 0.0, 0.0, 0.0];

  // Timers used
  Timer _timer;
  Timer _fishController;

  // Sets up the rods for the game
  void setupGame(int index) {
    // Makes the left rod a random size between 1 and 310
    _lWidth[index] = (1 + _rnd.nextInt(310)).toDouble();
    // Uses the left rod to make the right rod size to keep consistant gap
    _rWidth[index] = 310 - _lWidth[index];
  }

  // Writes data to the file if the highscore is greater than before
  Future<File> writeData() async {
    setState(() {
      if (_highScore < _currentScore) {
        isNewHigh = true;
        _highScore = _currentScore;
      }
    });

    // Waits 2 seconds before sending player to the game over screen
    await new Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GameOverScreen(
                  isNewScore: isNewHigh,
                  newScore: _highScore,
                )));

    // Stores the highscore
    return widget.storage.writeData(_highScore.toString());
  }

  // InitState that sets up the rods and animations
  @override
  void initState() {
    super.initState();
    // Gets the highscore from the file 1
    widget.storage.readData().then((String value) {
      _highScore = int.parse(value);
    });

    // Sets up the games rods
    for (var index = 0; index < _yAxis.length; index++) {
      setupGame(index);
    }

    // Starts a timer that will move the rods down the screen
    _timer = Timer.periodic(Duration(microseconds: 100), (timer) {
      setState(() {
        _yAxis[0] += 1;
        _yAxis[1] += 1;
        _yAxis[2] += 1;
        _yAxis[3] += 1;
        _yAxis[4] += 1;
      });

      // Check if the rod has hit the player
      checkHit(0);
      checkHit(1);
      checkHit(2);
      checkHit(3);
      checkHit(4);

      // Check if the rod is off screen
      resetRods(0);
      resetRods(1);
      resetRods(2);
      resetRods(3);
      resetRods(4);
    });

    // Timer used for fish animation
    _fishController = Timer.periodic(Duration(milliseconds: 200), (timer) {
      // Updates fish image from 1 to 3
      setState(() {
        _fish++;
      });
      if (_fish == 3) {
        _fish = 1;
      }
    });
  }

  // Disposes of timers and page
  @override
  void dispose() {
    super.dispose();
  }

  // Checks if the player has been hit by a rod
  void checkHit(int index) {
    // Checks if the rod is in position to hit the player
    if (_yAxis[index] > 630 && _yAxis[index] < 700) {
      // Checks if the players position on x Axis between both rods
      if (_xAxis < _lWidth[index] - 15 || _xAxis > _lWidth[index] + 87) {
        _timer.cancel();
        _fishController.cancel();
        writeData();
      }
    }
  }

  // Resets the rods position to the top of the screen to keep a continuous loop
  void resetRods(int index) {
    // Checks if the rod is past the size of the screen
    if (_yAxis[index] >= MediaQuery.of(context).size.height) {
      setState(() {
        // Updates score
        _currentScore = _currentScore + 100;
      });
      // Resets it 200 units higher than the top of the screen
      _yAxis[index] = -200;
      // Sets the rod width
      setupGame(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/sprites/$theme.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                  ),
                  // Player ***********************************************************************************************
                  Positioned(
                    top: 650,
                    left: _xAxis,
                    child: Container(
                      width: 50,
                      height: 100,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/sprites/$fishType$_fish.png'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  // *******************************************************************************************************
                  // Left Rods
                  Positioned(
                    top: _yAxis[0],
                    left: 0,
                    child: Container(
                      height: 20,
                      width: _lWidth[0],
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  Positioned(
                    top: _yAxis[1],
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      height: 20,
                      width: _lWidth[1],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[2],
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      height: 20,
                      width: _lWidth[2],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[3],
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      height: 20,
                      width: _lWidth[3],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[4],
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      height: 20,
                      width: _lWidth[4],
                    ),
                  ),
                  // Right rods
                  Positioned(
                    top: _yAxis[0],
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 20,
                      width: _rWidth[0],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[1],
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 20,
                      width: _rWidth[1],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[2],
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 20,
                      width: _rWidth[2],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[3],
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 20,
                      width: _rWidth[3],
                    ),
                  ),
                  Positioned(
                    top: _yAxis[4],
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[900],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 20,
                      width: _rWidth[4],
                    ),
                  ),
                  // CENTER TEXT
                  Positioned(
                    top: 700,
                    width: MediaQuery.of(context).size.width,
                    child: Slider(
                      activeColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      value: _xAxis,
                      min: 20,
                      max: MediaQuery.of(context).size.width - 70,
                      divisions:
                          (MediaQuery.of(context).size.width - 70).toInt(),
                      onChanged: (double value) {
                        setState(() {
                          _xAxis = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .111,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: SizedBox(
                            height: 35,
                            child: Text("Hi   Score",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontFamily: 'AtariClassic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                ),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(_highScore.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AtariClassic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                ),
                                textAlign: TextAlign.right),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.transparent,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .135,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: SizedBox(
                            height: 35,
                            child: Text("Score",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontFamily: 'AtariClassic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                ),
                                textAlign: TextAlign.left),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(_currentScore.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AtariClassic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                ),
                                textAlign: TextAlign.right),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
              ],
            ),
          ),
        )
      ],
    );
  }
}

/**
 * File management to save and retreive data
 */
class Storage {
  // Gets the file path 
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // Used to locate a file path
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/highscore.txt');
  }

  // Reads the data from the file
  Future<String> readData() async {
    try {
      final file = await localFile;
      String storage = await file.readAsString();

      return storage;
    } catch (ex) {
      return ex.toString();
    }
  }

  // Writes data to file 
  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}
