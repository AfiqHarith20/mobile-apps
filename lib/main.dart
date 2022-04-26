// ignore_for_file: prefer_const_constructors, annotate_overrides, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_print, must_be_immutable, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_complete_guild/result.dart';

import './quiz.dart';
import './result.dart';
//void main() {
//  runApp(MyApp());
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  //finall question = const []
  static const _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Blue', 'score': 10},
        {'text': 'Red', 'score': 2},
        {'text': 'Green', 'score': 6},
        {'text': 'White', 'score': 4}
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Cat', 'score': 10},
        {'text': 'Hamster', 'score': 8},
        {'text': 'Tiger', 'score': 4},
        {'text': 'Fish', 'score': 2}
      ],
    },
    {
      'questionText': 'What\'s your favorite hobi?',
      'answers': [
        {'text': 'Fishing', 'score': 8},
        {'text': 'Reading', 'score': 2},
        {'text': 'Gaming', 'score': 10},
        {'text': 'Traveling', 'score': 4}
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more question!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
