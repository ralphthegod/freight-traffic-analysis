import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainTextField extends StatefulWidget {
  
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  
  const MainTextField({super.key, required this.controller, required this.hintText, this.obscureText = false, this.icon = Icons.abc_rounded});

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, size: 24),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
    );
  }

}