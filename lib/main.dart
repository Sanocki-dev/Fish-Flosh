import 'dart:async';

import 'package:flutter/material.dart';
import 'game.dart';
import 'options.dart';
import 'information.dart';
import 'gamesettings.dart' as settings;

void main() {
  runApp(MyApp());
}

/**
 * Application setup and defaults
 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fish Flosh',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Color.fromRGBO(0, 166, 237, 1),
        accentColor: Color.fromRGBO(255, 180, 0, .5),
        fontFamily: 'AtariClassic',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OptionsScreen(title: 'Main Screen'),
    );
  }
}

/**
 * MainScreen Stateful Setup
 */
class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

/**
 * MainScreen Logic and Layout
 */
class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  // Animation Variables
  AnimationController _controller;
  bool isFading = true;

  // Theme variable
  String theme = settings.theme;

  // When the screen is loaded the init state will start a timer for the animation
  @override
  void initState() {
    // Timer for the fading in and out of the title
    Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        isFading = !isFading;
      });
    });

    // Controls the spining of gear
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.repeat();
    super.initState();
  }

  // Disposes of the timers and page
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/sprites/$theme.png'),
                    fit: BoxFit.fill)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Text("Fish\nflosh",
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 6),
                              )
                            ],
                            color: Colors.orange,
                            fontFamily: 'AtariClassic',
                            fontStyle: FontStyle.italic,
                            fontSize: 108,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    FlatButton(
                      height: MediaQuery.of(context).size.height * 0.40,
                      minWidth: double.infinity,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.transparent,
                      child: AnimatedOpacity(
                        opacity: isFading ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 2000),
                        child: Text(
                          "PRESS    START",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 6),
                                )
                              ],
                              fontSize: 60,
                              fontFamily: 'AtariClassic',
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen(
                                      storage: Storage(),
                                    )));
                      },
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          ' \u00a9 2020 MiKyGAMES',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 3),
                                )
                              ],
                              fontSize: 20,
                              fontFamily: 'AtariClassic',
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 30,
              right: 20,
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2,
                    child: child,
                  );
                },
                child: FloatingActionButton(
                    heroTag: "Settings",
                    child: Icon(
                      Icons.settings,
                      size: 50,
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue[100],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OptionsScreen()));
                    }),
              )),
          Positioned(
              top: 100,
              right: 20,
              child: FloatingActionButton(
                  heroTag: "Info",
                  child: Icon(
                    Icons.info_outline,
                    size: 50,
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.blue[100],
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InfoScreen()));
                  }))
        ],
      ),
    );
  }
}
