// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectAnswer;
  final String answerText;

  Answer(this.selectAnswer, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: selectAnswer,
      ),
    );
  }
}
