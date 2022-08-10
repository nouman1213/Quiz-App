import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz2.dart';

class ScoreScreen extends StatelessWidget {
  String points;
  ScoreScreen({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [whiteDark, purple],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headingText(text: 'Your Points are', color: white, size: 24),
              const SizedBox(height: 20),
              headingText(text: points, color: white, size: 24),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const QuizScreen2()));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: size.width - 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: purpleLight),
                  child: Center(
                      child: headingText(
                          text: 'Re-Start', size: 16, color: white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
