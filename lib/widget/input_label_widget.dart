import 'package:flutter/material.dart';

class InputLabelText extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final String text;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  const InputLabelText({
    Key? key,
    required this.padding,
    this.fontSize = 18,
    required this.text,
    this.fontWeight,
  }) : super(key: key);
}
