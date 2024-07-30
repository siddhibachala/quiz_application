import 'package:flutter/material.dart';

class QuizEndPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  QuizEndPage({
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    double scorePercentage = (totalQuestions > 0) ? (correctAnswers / totalQuestions) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Finished'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueAccent.shade100,
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration,
              size: 100.0,
              color: Colors.green,
            ),
            SizedBox(height: 20.0),
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'You have completed the quiz.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Score:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              '$correctAnswers / $totalQuestions',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              '${scorePercentage.toStringAsFixed(1)}% correct',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
