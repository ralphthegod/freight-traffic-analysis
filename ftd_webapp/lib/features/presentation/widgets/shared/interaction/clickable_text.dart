import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainClickableText extends StatefulWidget {

  final String text;
  final double fontSize;
  final Function onPressed;

  const MainClickableText({super.key, required this.text, required this.onPressed, this.fontSize = 14.0});

  @override
  State<MainClickableText> createState() => _MainClickableTextState();
}

class _MainClickableTextState extends State<MainClickableText> {

  @override
  Widget build(BuildContext context) {
    return 
    RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: widget.text,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: widget.fontSize,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onPressed();
                    }),
            ]),
          );
  }
  
}