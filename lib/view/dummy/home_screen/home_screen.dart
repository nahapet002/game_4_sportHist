import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/view/dummy/game_screen/game.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({Key? key}) : super(key: key);

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}


class _GameHomeScreenState extends State<GameHomeScreen> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home_screen.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.height / 5,
              height: MediaQuery.of(context).size.height / 5,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text(
                  'Play',
                  style: TextStyle(color: Colors.green, fontSize: 32.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
