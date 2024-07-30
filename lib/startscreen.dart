import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/questionscreen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
          backgroundColor: Colors.yellow.shade400,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/'
                  'quizbg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Quiz App Title
                Text(
                  'Welcome to Quiz App!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,  // Text color
                  ),
                ),
                SizedBox(height: 30.0),  // Spacer
                Image.asset(
                  'assets/question.png',
                  width: 150.0,
                  height: 150.0,
                  color: Colors.yellow,
                ),
                SizedBox(height: 30.0),  // Spacer

                // Start Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                  child: Text('Start Quiz'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.yellow.shade400,
                  )
                ),
              ],
            ),
          ),
        ),
      ));
  }
}

