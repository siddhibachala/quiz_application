import 'dart:async';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/quizendpage.dart';
import 'dart:convert';
import 'questionpage.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _start = 30;
  bool _isTimeUp = false;
  List<Map<String, dynamic>> _questions = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimeUp = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _fetchQuestions() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _questions = List<Map<String, dynamic>>.from(data['results']);
        _isLoading = false;
      });
    } else {
      print('Failed to load questions');
    }
  }

  void _handleAnswerSelected(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        _correctAnswers++;
      });
    }
  }

  void _handleNextPage() {
    print('Navigating to next page. Current index: $_currentQuestionIndex');

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionPage(
            question: _questions[_currentQuestionIndex],
            questionIndex: _currentQuestionIndex,
            onAnswerSelected: _handleAnswerSelected,
            onNextPage: _handleNextPage,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizEndPage(
            totalQuestions: _questions.length,
            correctAnswers: _correctAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isTimeUp
          ? Center(child: Text('Time’s Up!'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: QuestionPage(
                question: _questions[_currentQuestionIndex],
                questionIndex: _currentQuestionIndex,
                onAnswerSelected: _handleAnswerSelected,
                onNextPage: _handleNextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
