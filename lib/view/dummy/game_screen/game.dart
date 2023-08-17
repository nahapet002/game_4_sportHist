import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/core/shared_preferences/shared_preferences.dart';
import 'package:game/view/dummy/game_screen/questions.dart';
import 'package:game/view/dummy/game_screen/widgets/only_one_pointer_recognizer.dart';
import 'package:game/view/dummy/home_screen/home_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;

  int _currentQuestionIndex = 0;

  int pressedIndex = -1;
  bool isPressed = false;
  bool finish = false;

  Color defaultBackgroundColor = CupertinoColors.extraLightBackgroundGray;
  Color defaultForegroundColor = CupertinoColors.black;

  Color newBackground = CupertinoColors.extraLightBackgroundGray;
  Color newBorderColor = CupertinoColors.extraLightBackgroundGray;
  Color newForegroundColor = CupertinoColors.black;
  double fontSize = 20;

  void checkAnswer(bool isTrue) {
    setState(() {
      newBorderColor = Colors.green;
      fontSize = 28;
    });
    if (isTrue == true) {
      setState(() {
        newBackground = Colors.green;
        score++;
        if (score > UserPreferences().getTop1()!) {
          UserPreferences.setTop1(score);
        }
      });
    } else {
      setState(() {
        newBackground = Colors.red;
        newForegroundColor = Colors.green;
      });
    }
  }

  void _nextQuestion() async {
    await Future.delayed(Duration(milliseconds: 1000));
    newBackground = defaultBackgroundColor;
    newBorderColor = defaultBackgroundColor;
    newForegroundColor = defaultForegroundColor;
    fontSize = 20;
    pressedIndex = -1;
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        isPressed = false;
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        finish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic> currentQuestion = questions[_currentQuestionIndex];
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Score: $score',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: finish == false
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.extraLightBackgroundGray,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              currentQuestion['question'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        SizedBox(
                          height: size.height / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            child: Image.asset(
                              'assets/image_${_currentQuestionIndex + 1}.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        OnlyOnePointerRecognizerWidget(
                          child: SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                                itemCount: currentQuestion['answers'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var answer =
                                      currentQuestion['answers'][index];
                                  var correctAnswer = answer['correct_answer'];
                                  return Column(
                                    children: [
                                      SizedBox(height: 5),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(320, 50),
                                          backgroundColor:
                                              answer['answer_id'] ==
                                                      pressedIndex
                                                  ? newBackground
                                                  : defaultBackgroundColor,
                                          foregroundColor:
                                              correctAnswer == 'true'
                                                  ? newForegroundColor
                                                  : defaultForegroundColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: correctAnswer == 'true'
                                                  ? newBorderColor
                                                  : defaultBackgroundColor,
                                              width: isPressed == true &&
                                                      correctAnswer == 'true'
                                                  ? 5
                                                  : 0,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          shadowColor: Colors.black,
                                          elevation: 2,
                                        ),
                                        onPressed: () {
                                          if (isPressed == false) {
                                            setState(() {
                                              pressedIndex = index;
                                            });
                                            correctAnswer == 'true'
                                                ? checkAnswer(true)
                                                : checkAnswer(false);
                                            setState(() {
                                              isPressed = true;
                                            });
                                            _nextQuestion();
                                          }
                                        },
                                        child: Text(
                                          answer['answer_text'],
                                          style: TextStyle(
                                            fontSize: correctAnswer == 'true'
                                                ? fontSize
                                                : 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: size.width * 0.8,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Current score: ',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$score',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Best score: ',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${UserPreferences().getTop1()}',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameHomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
