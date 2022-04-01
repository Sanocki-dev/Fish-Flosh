import 'package:flutter/material.dart';
import 'main.dart';
import 'gamesettings.dart' as setting;

/**
 * OptionsScreen Stateful Setup
 */
class OptionsScreen extends StatefulWidget {
  OptionsScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

/**
 * OptionsScreen Logic and Layout
 */
class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'Options',
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 3),
                )
              ],
              color: Colors.white,
              fontSize: 80,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  'Select your fish',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.fish = "fish";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: setting.fish == "fish"
                                ? Colors.yellow
                                : Colors.transparent,
                            width: 2),
                        image: DecorationImage(
                            image: AssetImage('assets/sprites/fish1.png'),
                            fit: BoxFit.fill)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.fish = "green";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.fish == "green"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/green1.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.fish = "purple";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.fish == "purple"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/purple1.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.fish = "multi";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.fish == "multi"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/multi1.png'),
                              fit: BoxFit.fill)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
         Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  'Select your theme',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.theme = "water";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.theme == "water"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/waterpre.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.theme = "lava";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.theme == "lava"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/lavapre.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setting.theme = "grass";
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: setting.theme == "grass"
                                  ? Colors.yellow
                                  : Colors.transparent,
                              width: 2),
                          image: DecorationImage(
                              image: AssetImage('assets/sprites/grasspre.png'),
                              fit: BoxFit.fill)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 100,
          child: FlatButton(
              textColor: Colors.white,
              height: 200,
              minWidth: 200,
              child: Text(
                "Home",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white,
                  fontSize: 80,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              }),
        )
      ]),
    );
  }
}
