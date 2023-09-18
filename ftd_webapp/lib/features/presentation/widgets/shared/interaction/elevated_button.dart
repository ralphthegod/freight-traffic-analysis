import 'package:flutter/material.dart';

class MainElevatedButton extends StatefulWidget {

  final String text;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final Function onPressed;  
  const MainElevatedButton({super.key, required this.text, required this.onPressed, this.fontSize = 14.0, this.verticalPadding = 15.0, this.horizontalPadding = 30.0});

  @override
  State<MainElevatedButton> createState() => _MainElevatedButtonState();
}

class _MainElevatedButtonState extends State<MainElevatedButton> {

  @override
  Widget build(BuildContext context) {
    return 
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
        ),         
      ),
    );
  }
  
}