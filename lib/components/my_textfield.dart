import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool isPasswordField;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.isPasswordField,
    this.focusNode
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        

        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        

        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary)
          ),
         focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
           borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
         ),

         fillColor: Theme.of(context).colorScheme.secondary,
         filled: true,

         hintText: hintText,
         hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),

        
       
        ),
      ),
    );
  }
}