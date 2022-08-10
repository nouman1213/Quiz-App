import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz_app/quiz_screen.dart';

import 'const/colors.dart';
import 'const/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const QuizApp()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                headingText(text: 'Quiz App', color: white, size: 24),
                const SizedBox(height: 20),
                Image.asset('assets/images/quiz.png'),
                const SizedBox(height: 20),
              ]))),
    );
  }
}
