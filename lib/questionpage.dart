import 'package:flutter/material.dart';
import 'dart:async';

class QuestionPage extends StatefulWidget {
  final Map<String, dynamic> question;
  final int questionIndex;
  final void Function(bool isCorrect) onAnswerSelected;
  final VoidCallback onNextPage;

  QuestionPage({
    required this.question,
    required this.questionIndex,
    required this.onAnswerSelected,
    required this.onNextPage,
  });

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Timer? _timer;
  int _start = 10;
  bool _isTimeUp = false;
  String? _selectedAnswer;
  late String _correctAnswer;
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _correctAnswer = widget.question['correct_answer'];
    _options = List<String>.from(widget.question['incorrect_answers'])
      ..add(_correctAnswer);
    _options.shuffle();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimeUp = true;
        });
        _timer?.cancel();
        widget.onAnswerSelected(false); // No answer selected, so false
        Future.delayed(Duration(milliseconds: 500), widget.onNextPage);
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${widget.questionIndex + 1}'),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.blueAccent.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question['question'] ?? 'No question available',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Time Remaining: $_start seconds',
              style: TextStyle(
                fontSize: 18.0,
                color: _isTimeUp ? Colors.red : Colors.black54,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final option = _options[index];
                  final isSelected = _selectedAnswer == option;
                  final isCorrect = option == _correctAnswer;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Material(
                      color: _isTimeUp
                          ? (isCorrect
                          ? Colors.green[300]
                          : (isSelected ? Colors.red[300] : Colors.grey[200]))
                          : (isSelected ? Colors.blue[100] : Colors.white),
                      borderRadius: BorderRadius.circular(12.0),
                      elevation: 4.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          if (!_isTimeUp && _selectedAnswer == null) {
                            setState(() {
                              _selectedAnswer = option;
                              _isTimeUp = true; // Mark as answered
                            });
                            _timer?.cancel();
                            widget.onAnswerSelected(isCorrect);
                            Future.delayed(Duration(milliseconds: 500), widget.onNextPage);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: _isTimeUp
                                  ? (isSelected
                                  ? Colors.white
                                  : Colors.black87)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
