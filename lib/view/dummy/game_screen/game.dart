import 'package:flutter/material.dart';
import 'package:game/view/dummy/game_screen/questions.dart';

import '../home_screen/home_screen.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int currentQuestionIndex = 0;
  int score = 0;
  int life = 3;
  Color lifeColor = Colors.white;
  double lifeFontSize = 28;

  String question = '';
  String image = '';
  List<String> hiddenWord = [];
  List<bool> letterRevealed = [];

  bool finish = false;

  Color buttonColor = Colors.blueGrey;
  List<String> rightLetters = [];
  List<String> wrongLetters = [];

  @override
  void initState() {
    super.initState();
    startNewQuestion();
  }

  void startNewQuestion() {
    final newWord = questions[currentQuestionIndex]['answer'];
    question = questions[currentQuestionIndex]['question'];
    image = questions[currentQuestionIndex]['image'];
    hiddenWord = newWord.split('');
    letterRevealed = List.generate(newWord.length, (index) => false);
  }

  Future<void> moveToNextQuestion() async {
    await Future.delayed(Duration(milliseconds: 500));
    rightLetters.clear();
    wrongLetters.clear();
    setState(() {
      score++;
      life = 3;
    });
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        startNewQuestion();
      });
    } else {
      setState(() {
        finish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/quiz_back.webp'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.blueGrey.withOpacity(0.6),
          foregroundColor: Colors.white,
          centerTitle: true,
          title:
              Text("Question ${currentQuestionIndex + 1}/${questions.length}"),
          actions: [
            Icon(Icons.favorite, color: Colors.red, size: 28),
            Text(' $life', style: TextStyle(color: lifeColor, fontSize: lifeFontSize)),
            SizedBox(width: 10)
          ],
        ),
        bottomNavigationBar: finish == false
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                height: 200,
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildRow(
                        ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildRow(
                        ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildRow(
                        ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: finish == false
            ? SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    child: Image(
                                      image: AssetImage(image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(108, 167, 178, 1),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    color: Color.fromRGBO(104, 147, 155, 1.0),
                                  ),
                                  child: Text(
                                    question,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 50.0 * hiddenWord.length,
                            height: 50,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 50,
                                crossAxisSpacing: 5,
                                crossAxisCount: hiddenWord.length,
                              ),
                              itemCount: hiddenWord.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  constraints: BoxConstraints(
                                    maxWidth: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    color: letterRevealed[index]
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      letterRevealed[index]
                                          ? hiddenWord[index]
                                          : '',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      score == questions.length
                          ? Center(
                              child: Text(
                                'You guessed all the words',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Answered questions: ',
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

  List<Widget> _buildRow(List<String> letters) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSpacing = 8.0;
    final totalSpacing = letters.length * buttonSpacing;

    final availableWidth = screenWidth - totalSpacing;
    final buttonWidth = availableWidth / 10;

    return letters.map((letter) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
        child: SizedBox(
          width: buttonWidth,
          height: 50,
          child: InkWell(
            onTap: () async {
              if (hiddenWord.contains(letter)) {
                rightLetters.add(letter);
                setState(() {
                  for (var i = 0; i < hiddenWord.length; i++) {
                    if (hiddenWord[i] == letter) {
                      letterRevealed[i] = true;
                    }
                  }
                });
              } else {
                wrongLetters.add(letter);
                setState(() {
                  life--;
                  lifeFontSize = 38;
                  lifeColor = Colors.red;
                });
                await Future.delayed(Duration(milliseconds: 500));
                if (life == 0) {
                  setState(() {
                    finish = true;
                  });
                } else {
                  setState(() {
                    lifeFontSize = 28;
                    lifeColor = Colors.white;
                  });
                }
              }
              if (letterRevealed.every((revealed) => revealed)) {
                moveToNextQuestion();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: rightLetters.contains(letter)
                    ? Colors.green
                    : wrongLetters.contains(letter)
                        ? Colors.transparent
                        : buttonColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
