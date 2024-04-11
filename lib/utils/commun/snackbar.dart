import 'package:flutter/material.dart';

void showCustomSnackBar( context,  message,color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,style: TextStyle(color:color),),
      duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
  );
}