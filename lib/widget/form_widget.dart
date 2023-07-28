import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String? initValue;
  final String? hintText;
  final String? labelText;
  final double fontSize;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FontWeight fontWeight;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final void Function()? oNtap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.055,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          maxLines: 1,
          initialValue: initValue,
          style: TextStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            fillColor: Colors.grey[200],
            filled: true,
            labelText: labelText,
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            hintText: hintText,
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }

  const FormWidget({
    Key? key,
    this.initValue,
    this.hintText,
    this.fontSize = 26.0,
    this.validator,
    this.onChanged,
    this.onTap,
    this.fontWeight = FontWeight.normal,
    this.onEditingComplete,
    this.keyboardType = TextInputType.number,
    this.labelText,
    this.oNtap,
    this.controller,
  }) : super(key: key);
}
