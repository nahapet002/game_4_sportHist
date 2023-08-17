import 'package:flutter/material.dart';

enum BallState {
  ideal,
  drag,
  release,
  completed,
}

const ballRadius = 10.0;

const ballColor = 0xFFFFFFFF;

const brickColor = Color.fromRGBO(85, 152, 246, 1.0);
const brickFontColor = 0xFFFFFFFF;
const brickFontSize = 20.0;

const numberOfBricksInRow = 7;
const brickPadding = 8;
const maxValueOfBrick = 10;
const minValueOfBrick = -5;

const Color panelColor = Color.fromRGBO(26, 39, 52, 1.0);

Color startButtonColor = Colors.white.withOpacity(0.8);
const Color continueButtonColor = Color.fromRGBO(80, 129, 82, 1.0);
const Color restartButtonColor = Color.fromRGBO(7, 92, 161, 1.0);
const Color tryAgainButtonColor = Color.fromRGBO(147, 56, 56, 1.0);
