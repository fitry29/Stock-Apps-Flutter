import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double height;
  final double width;
  final double radius;
  final Color buttonColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          primary: buttonColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  const ElevatedButtonWidget({
    Key? key,
    this.onPressed,
    this.text = 'Save',
    required this.height,
    required this.width,
    this.radius = 50,
    this.buttonColor = Colors.yellowAccent,
    this.elevation = 1,
  }) : super(key: key);
}
