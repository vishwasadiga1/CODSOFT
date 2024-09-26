import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/home_screen.dart';

void main() {
  runApp(QuoteOfTheDayApp());
}

class QuoteOfTheDayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote of the Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteHomeScreen(),
    );
  }
}
