import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz_app/const/colors.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/quiz2.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [whiteDark, purple],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Image(
                    color: white,
                    image: AssetImage(
                      'assets/images/lightIcon.png',
                    ))),
            const SizedBox(height: 40),
            normalText(color: Colors.white, text: 'Welcome to our', size: 20),
            const SizedBox(height: 10),
            headingText(text: 'Quiz App', color: white, size: 24),
            const SizedBox(height: 20),
            normalText(
                text:
                    'Do you feel confidents? To face our most difficults questions!',
                color: white,
                size: 18),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QuizScreen2()));
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: size.width - 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: purpleLight),
                  child: Center(
                      child: headingText(
                          text: 'Continue', size: 16, color: white)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
