import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonName,
    required this.buttonColor,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;
  final String buttonName;
  final Color buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
