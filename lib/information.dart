import 'package:flutter/material.dart';
import 'main.dart';

/**
 * InfoScreen Logic and Layout
 */
class InfoScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'About Us',
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
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'Developer\nMike   Sanocki',
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
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'Developer\nKyle   Stamant',
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
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'Created For Durham College Mobile Development Course',
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 3),
                )
              ],
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
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
